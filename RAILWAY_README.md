# 🚂 Railway Deployment for Langflow

This repository is optimized for one-click deployment to Railway with production-ready configurations.

## 🚀 Quick Deploy

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template)

### Prerequisites
- Railway account (free to start)
- GitHub account (for automatic deployments)

### Steps
1. Click the "Deploy on Railway" button above
2. Connect your GitHub account
3. Railway will automatically:
   - Detect the `railway.toml` configuration
   - Build using the optimized `railway.Dockerfile`
   - Deploy your Langflow instance
   - Generate a public URL

## 📁 Files Overview

| File | Purpose |
|------|---------|
| `railway.toml` | Railway platform configuration |
| `railway.Dockerfile` | Optimized Docker build for Railway |
| `.railwayignore` | Excludes unnecessary files from deployment |
| `RAILWAY_DEPLOYMENT.md` | Comprehensive deployment guide |
| `RAILWAY_OPTIMIZATION_SUMMARY.md` | Technical optimization details |
| `.env.railway.example` | Environment variables template |
| `railway-deploy.sh` | CLI deployment helper script |

## ⚙️ Configuration

### Essential Environment Variables

Set these in the Railway dashboard under your service's "Variables" tab:

```bash
# Admin Credentials (recommended)
LANGFLOW_SUPERUSER=admin
LANGFLOW_SUPERUSER_PASSWORD=your-secure-password

# Database (auto-set when you add PostgreSQL)
DATABASE_URL=postgresql://...
```

### Optional Variables

```bash
# Logging
LANGFLOW_LOG_LEVEL=INFO

# Performance
LANGFLOW_WORKERS=1

# Security
LANGFLOW_AUTO_LOGIN=false
LANGFLOW_NEW_USER_IS_ACTIVE=false
```

## 🗄️ Database Setup

### PostgreSQL (Recommended for Production)

1. In Railway dashboard, click "New" → "Database" → "Add PostgreSQL"
2. Railway automatically sets `DATABASE_URL`
3. Langflow will use PostgreSQL automatically

### SQLite (Development Only)

- Default configuration
- No additional setup needed
- **Warning**: Data is ephemeral on Railway (lost on redeploy)

## 📊 Monitoring

### Health Checks
- Endpoint: `https://your-app.railway.app/health_check`
- Automatically monitored by Railway
- Configured in `railway.toml`

### Logs
```bash
# Install Railway CLI
npm i -g @railway/cli

# View logs
railway logs
```

## 🔧 Local Development

### Using Railway CLI

```bash
# Clone repository
git clone https://github.com/your-username/langflow
cd langflow

# Install Railway CLI
npm i -g @railway/cli

# Login and deploy
./railway-deploy.sh
```

### Using Docker

```bash
# Build Railway-optimized image
docker build -f railway.Dockerfile -t langflow-railway .

# Run locally
docker run -p 7860:7860 \
  -e LANGFLOW_HOST=0.0.0.0 \
  -e LANGFLOW_PORT=7860 \
  langflow-railway
```

## 📈 Scaling

### Vertical Scaling
- Upgrade Railway plan for more CPU/RAM
- Adjust `LANGFLOW_WORKERS` environment variable

### Horizontal Scaling
1. Add PostgreSQL database (required)
2. Add Redis for caching (optional)
3. Deploy multiple instances in Railway dashboard

## 💰 Cost Estimates

| Plan | Monthly Cost | Best For |
|------|--------------|----------|
| Hobby | $0 | Testing, personal projects |
| Starter | $5-15 | Small production apps |
| Pro | $20+ | Production with traffic |

*Add $5/month for PostgreSQL, $5/month for Redis*

## 🛠️ Troubleshooting

### Build Fails
- Check Railway build logs in dashboard
- Verify `uv.lock` is committed to repository
- Ensure all dependencies are in `pyproject.toml`

### Can't Access Application
- Check Railway logs for errors
- Verify environment variables are set
- Ensure health check endpoint is responding

### Performance Issues
- Upgrade Railway plan
- Add PostgreSQL if using SQLite
- Enable Redis caching
- Increase `LANGFLOW_WORKERS`

## 📚 Documentation

- **[RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md)** - Complete deployment guide
- **[RAILWAY_OPTIMIZATION_SUMMARY.md](./RAILWAY_OPTIMIZATION_SUMMARY.md)** - Technical details
- **[Langflow Docs](https://docs.langflow.org)** - Official Langflow documentation
- **[Railway Docs](https://docs.railway.app)** - Railway platform documentation

## 🔒 Security

- ✅ No hardcoded secrets
- ✅ Environment variable based configuration
- ✅ Auto-login disabled by default
- ✅ User activation required
- ✅ Health check monitoring

## 🤝 Support

- **Railway Issues**: [Railway Discord](https://discord.gg/railway)
- **Langflow Issues**: [Langflow Discord](https://discord.gg/EqksyE2EX9)
- **GitHub Issues**: [Create an issue](https://github.com/langflow-ai/langflow/issues)

## 📝 License

MIT License - Same as Langflow

---

**Ready to deploy?** Click the button at the top or run `./railway-deploy.sh`
