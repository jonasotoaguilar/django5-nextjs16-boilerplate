import type { DefaultSession } from 'next-auth'

declare module 'next-auth' {
  interface User {
    id: number
    username: string
    access: string
    refresh: string
  }

  interface Session {
    accessToken?: string
    refreshToken?: string
    user: {
      id: number
      username: string
    } & Omit<DefaultSession['user'], 'id'>
  }
}

declare module 'next-auth/jwt' {
  interface JWT {
    id: number
    username: string
    access: string
    refresh: string
  }
}
