# Railway Deployment Troubleshooting

## ✅ Fixed: "Script start.sh not found" Error

This error occurred because Railway was trying to auto-detect the build method instead of using the Dockerfile.

**Solution Applied:**
- Updated `railway.json` to explicitly use Dockerfile
- Fixed CMD in Dockerfile to use Railway's `$PORT` variable
- Removed conflicting `startCommand` from railway.json

## 🚀 Deploy Now

The configuration is fixed. Try deploying again:

### Option 1: Redeploy in Railway Dashboard

1. Go to your Railway project
2. Click **"Redeploy"** or trigger a new deployment
3. Railway should now detect and use the Dockerfile

### Option 2: Fresh Deploy

1. Delete the failed deployment (if any)
2. Go to https://railway.app/new
3. Click "Deploy from GitHub repo"
4. Select `klogins-hash/langflow`
5. Railway will now use the Dockerfile correctly

## 📋 Deployment Checklist

After Railway starts building:

- [ ] Build uses Dockerfile (check build logs)
- [ ] Build completes successfully (~10-15 minutes)
- [ ] Add environment variables:
  ```
  LANGFLOW_DATABASE_URL=sqlite:////app/data/.cache/langflow/langflow.db
  LANGFLOW_HOST=0.0.0.0
  LANGFLOW_LOG_LEVEL=INFO
  ```
- [ ] Add Volume at `/app/data` for persistence
- [ ] Generate domain
- [ ] Access Langflow UI
- [ ] Generate API key

## 🔍 Check Build Logs

In Railway dashboard:
1. Click on your service
2. Go to "Deployments" tab
3. Click on the latest deployment
4. View build logs to confirm it's using Dockerfile

You should see:
```
Building with Dockerfile...
Step 1/XX : FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder
```

## ⚙️ Configuration Files

**Dockerfile** - Multi-stage build
- Stage 1: Build dependencies and frontend
- Stage 2: Runtime environment

**railway.json** - Railway configuration
```json
{
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "./Dockerfile"
  }
}
```

## 🆘 Still Having Issues?

### Issue: Build Timeout
**Solution**: Railway free tier has build time limits. The first build takes ~10-15 minutes.
- Upgrade to hobby plan for faster builds
- Or wait for build to complete

### Issue: Out of Memory
**Solution**: Frontend build needs memory
- Railway should auto-allocate enough memory
- If fails, try deploying with Railway Pro

### Issue: Can't Access After Deploy
**Solution**: Check these:
1. Deployment status is "Active"
2. Domain is generated
3. Health check is passing at `/health_check`
4. Check deployment logs for errors

## 📝 Environment Variables Reference

Required:
- `LANGFLOW_HOST=0.0.0.0`
- `LANGFLOW_DATABASE_URL=sqlite:////app/data/.cache/langflow/langflow.db`

Optional:
- `LANGFLOW_LOG_LEVEL=INFO` (or DEBUG for troubleshooting)
- `LANGFLOW_AUTO_LOGIN=false`
- API keys for LLM providers (OpenAI, Anthropic, etc.)

## 🎯 Next Steps After Successful Deploy

1. Open your Railway domain
2. Complete Langflow setup
3. Generate API key (Settings → API Keys)
4. Update your Python client `.env`:
   ```bash
   cd /Users/franksimpson/CascadeProjects/langflow-project
   # Edit .env with new URL and API key
   ```
5. Test connection:
   ```bash
   python test_connection.py
   ```

---

**The configuration is now fixed and ready to deploy! 🚀**
