# Railway Deployment Guide for Langflow

This guide explains how to deploy Langflow to Railway with optimized configuration.

## Quick Deploy

### Option 1: Deploy from GitHub (Recommended)

1. **Fork or push this repository to GitHub**

2. **Create a new project on Railway**
   - Go to [Railway](https://railway.app)
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your Langflow repository

3. **Railway will automatically detect the configuration**
   - The `railway.toml` file configures the build and deployment
   - The `railway.Dockerfile` is optimized for Railway

4. **Add a PostgreSQL database (Optional but Recommended)**
   - Click "New" → "Database" → "Add PostgreSQL"
   - Railway will automatically set the `DATABASE_URL` environment variable
   - Langflow will use this instead of SQLite

5. **Configure environment variables** (Optional)
   - `LANGFLOW_SUPERUSER` - Admin username (default: auto-generated)
   - `LANGFLOW_SUPERUSER_PASSWORD` - Admin password (default: auto-generated)
   - `LANGFLOW_SECRET_KEY` - Secret key for sessions (auto-generated if not set)
   - `LANGFLOW_AUTO_LOGIN` - Set to "true" for auto-login (not recommended for production)

### Option 2: Deploy using Railway CLI

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login to Railway
railway login

# Initialize project
railway init

# Link to a new project
railway link

# Deploy
railway up
```

## Configuration Files

### `railway.toml`
Main configuration file that tells Railway:
- How to build the application (using Dockerfile)
- Start command
- Health check endpoint
- Default environment variables

### `railway.Dockerfile`
Optimized Dockerfile that:
- Uses Python 3.12 slim image for smaller size
- Installs `uv` for faster dependency installation
- Includes health checks
- Creates necessary directories

### `.railwayignore`
Excludes unnecessary files from deployment to:
- Speed up build times
- Reduce deployment size
- Improve security

## Database Options

### SQLite (Default - Development Only)
- Automatically configured
- Data stored in `/app/data/.cache/langflow/langflow.db`
- **Not recommended for production** (ephemeral storage on Railway)

### PostgreSQL (Recommended for Production)
1. Add PostgreSQL service in Railway dashboard
2. Railway automatically sets `DATABASE_URL`
3. Langflow will use PostgreSQL automatically

Example DATABASE_URL format:
```
postgresql://user:password@host:port/database
```

## Environment Variables

Key environment variables you can set in Railway:

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Port to run on (set by Railway) | Auto-set by Railway |
| `LANGFLOW_DATABASE_URL` | Database connection string | Uses Railway's DATABASE_URL or SQLite |
| `LANGFLOW_LOG_LEVEL` | Logging level | INFO |
| `LANGFLOW_SUPERUSER` | Admin username | Auto-generated |
| `LANGFLOW_SUPERUSER_PASSWORD` | Admin password | Auto-generated |
| `LANGFLOW_SECRET_KEY` | Session secret key | Auto-generated |
| `LANGFLOW_AUTO_LOGIN` | Enable auto-login | false |
| `LANGFLOW_WORKERS` | Number of workers | 1 |

## Scaling Considerations

### Vertical Scaling
- Increase Railway plan for more CPU/RAM
- Adjust `LANGFLOW_WORKERS` based on available resources

### Horizontal Scaling
- Use PostgreSQL (required for multiple instances)
- Add Redis for caching (optional):
  ```bash
  railway add redis
  ```
- Set environment variables:
  ```
  LANGFLOW_CACHE_TYPE=redis
  LANGFLOW_REDIS_HOST=$REDIS_HOST
  LANGFLOW_REDIS_PORT=$REDIS_PORT
  ```

## Monitoring

### Health Checks
- Endpoint: `/health_check`
- Configured in `railway.toml`
- Railway automatically monitors this endpoint

### Logs
View logs in Railway dashboard or via CLI:
```bash
railway logs
```

## Troubleshooting

### Build Failures
1. Check Railway build logs
2. Ensure all dependencies are in `pyproject.toml`
3. Verify `uv.lock` is up to date

### Runtime Errors
1. Check environment variables are set correctly
2. Verify database connection (if using PostgreSQL)
3. Check logs for specific error messages

### Performance Issues
1. Increase Railway plan resources
2. Add PostgreSQL if using SQLite
3. Enable Redis caching
4. Adjust `LANGFLOW_WORKERS`

## Cost Optimization

1. **Use the Hobby plan** for development/testing
2. **Add PostgreSQL only when needed** (starts at $5/month)
3. **Monitor usage** in Railway dashboard
4. **Use sleep mode** for non-production environments

## Security Best Practices

1. **Set strong passwords** for `LANGFLOW_SUPERUSER_PASSWORD`
2. **Use PostgreSQL** for production (not SQLite)
3. **Keep `LANGFLOW_AUTO_LOGIN` disabled** in production
4. **Use environment variables** for all secrets (never commit them)
5. **Enable Railway's** built-in security features

## Additional Resources

- [Railway Documentation](https://docs.railway.app)
- [Langflow Documentation](https://docs.langflow.org)
- [Langflow GitHub](https://github.com/langflow-ai/langflow)

## Support

For issues specific to:
- **Railway deployment**: [Railway Discord](https://discord.gg/railway)
- **Langflow application**: [Langflow Discord](https://discord.gg/EqksyE2EX9)
