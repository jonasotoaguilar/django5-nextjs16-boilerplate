import { ApiError } from '@frontend/types/api'
import NextAuth from 'next-auth'
import CredentialsProvider from 'next-auth/providers/credentials'
import { getApiClient } from './api'

function decodeToken(token: string): {
  token_type: string
  exp: number
  iat: number
  jti: string
  user_id: number
} {
  try {
    return JSON.parse(atob(token.split('.')[1]))
  } catch {
    return { token_type: '', exp: 0, iat: 0, jti: '', user_id: 0 }
  }
}

export const { handlers, auth, signIn, signOut } = NextAuth({
  session: {
    strategy: 'jwt'
  },
  pages: {
    signIn: '/login'
  },
  callbacks: {
    session: async ({ session, token }) => {
      if (token && typeof token.id === 'number') {
        session.user.id = token.id as unknown as string
        session.user.username = token.username as string
        session.accessToken = token.access as string
        session.refreshToken = token.refresh as string
      }
      return session
    },
    jwt: async ({ token, user }) => {
      if (user) {
        token.id = user.id as unknown as number
        token.username = user.username as string
        token.access = user.access as string
        token.refresh = user.refresh as string
      }

      // Check if access token is expired
      const access = decodeToken((token.access as string) ?? '')
      const now = Date.now() / 1000

      if (token.access && now > access.exp - 60) {
        // Only refresh if we have a refresh token
        if (token.refresh) {
          try {
            const apiClient = await getApiClient()
            const res = await apiClient.token.tokenRefreshCreate({
              access: token.access as string,
              refresh: token.refresh as string
            })
            return {
              ...token,
              access: res.access
            }
          } catch (error) {
            console.error('Error refreshing access token', error)
            return { ...token, error: 'RefreshAccessTokenError' }
          }
        }
      }

      return token
    }
  },
  providers: [
    CredentialsProvider({
      name: 'credentials',
      credentials: {
        username: { label: 'Email', type: 'text' },
        password: { label: 'Password', type: 'password' }
      },
      async authorize(credentials) {
        if (!credentials?.username || !credentials?.password) {
          return null
        }

        try {
          const apiClient = await getApiClient()
          const res = await apiClient.token.tokenCreate({
            username: credentials.username as string,
            password: credentials.password as string,
            access: '',
            refresh: ''
          })

          return {
            id: decodeToken(res.access).user_id,
            username: credentials.username as string,
            access: res.access,
            refresh: res.refresh,
            email: credentials.username as string
          }
        } catch (error) {
          if (error instanceof ApiError) {
            return null
          }
          console.error('Auth error:', error)
          return null
        }
      }
    })
  ]
})
