# Railway Deployment Instructions

## ⚠️ Important: Manual Configuration Required

Railway auto-detection may fail. Follow these steps:

### Option 1: Configure in Railway Dashboard (Recommended)

1. **Create New Project** in Railway
2. **Connect GitHub repo**: `klogins-hash/langflow`
3. **In Settings → Build**:
   - Builder: **Docker**
   - Dockerfile Path: `Dockerfile`
   - Build Command: (leave empty)
4. **In Settings → Deploy**:
   - Start Command: (leave empty - uses Dockerfile CMD)
5. **Add Environment Variables**:
   ```
   LANGFLOW_HOST=0.0.0.0
   LANGFLOW_DATABASE_URL=sqlite:////app/data/.cache/langflow/langflow.db
   LANGFLOW_LOG_LEVEL=INFO
   ```
6. **Add Volume**:
   - Mount Path: `/app/data`
7. **Deploy**

### Option 2: Use Railway CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Link to your project (or create new)
cd /Users/franksimpson/CascadeProjects/langflow-custom
railway link

# Set to use Dockerfile
railway up --dockerfile Dockerfile

# Add environment variables
railway variables set LANGFLOW_HOST=0.0.0.0
railway variables set LANGFLOW_DATABASE_URL="sqlite:////app/data/.cache/langflow/langflow.db"
railway variables set LANGFLOW_LOG_LEVEL=INFO

# Add volume via dashboard (can't do via CLI)
```

### Option 3: Deploy Button

Click this button to deploy:

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/langflow)

Then manually configure the Dockerfile path in settings.

## Files in This Repo

- **`Dockerfile`** - Production build configuration
- **`railway.toml`** - Railway configuration (may not auto-detect)
- **`.railwayignore`** - Ignore conflicting files

## Troubleshooting

### "Script start.sh not found"
Railway is trying to use Nixpacks instead of Docker.

**Fix**: Manually set Builder to "Docker" in Railway dashboard → Settings → Build

### "Could not determine how to build"
Railway can't auto-detect the build method.

**Fix**: 
1. Go to Railway dashboard
2. Settings → Build
3. Set Builder: **Docker**
4. Set Dockerfile Path: **Dockerfile**

### Build takes too long
First build takes 10-15 minutes due to:
- Installing Python dependencies
- Building frontend (npm build)
- Multi-stage Docker build

**This is normal!** Subsequent builds are faster with caching.

## After Successful Deploy

1. Generate domain in Railway dashboard
2. Open Langflow UI
3. Create API key (Settings → API Keys)
4. Update your Python client:
   ```bash
   cd /Users/franksimpson/CascadeProjects/langflow-project
   # Edit .env with new URL and API key
   ```

---

**If auto-detection fails, manually configure Docker builder in Railway dashboard!**
