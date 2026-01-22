# syntax=docker/dockerfile:1
FROM node:24-alpine AS base

LABEL maintainer="https://github.com/jonasotoaguilar/django5-nextjs16-boilerplate"

# Enable corepack for pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install dependencies only when needed
FROM base AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
# hadolint ignore=DL3018
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Copy all source code (needed for pnpm workspaces)
COPY . .

# Install all dependencies
RUN pnpm install --frozen-lockfile

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app

# Copy everything from deps (includes node_modules and source)
COPY --from=deps /app ./

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry during the build.
ENV NEXT_TELEMETRY_DISABLED=1

RUN pnpm run build

# Development stage
FROM base AS dev
WORKDIR /app

# Set up environment for development
ENV NODE_ENV=development
ENV NEXT_TELEMETRY_DISABLED=1
USER node

# Copy everything from builder (includes node_modules and source)
COPY --from=builder --chown=node:node /app /app

# Run development server with hot-reloading
CMD ["pnpm", "run", "dev"]

# Production stage
FROM base AS prod
WORKDIR /app

# Set up environment for production
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

COPY --from=builder --chown=nextjs:nodejs /app/apps/web/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/apps/web/.next/static ./apps/web/.next/static
COPY --from=builder --chown=nextjs:nodejs /app/apps/web/public ./apps/web/public

USER nextjs

EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
# server.js is created by next build from the standalone output
# https://nextjs.org/docs/pages/api-reference/next-config-js/output
CMD ["node", "apps/web/server.js"]
