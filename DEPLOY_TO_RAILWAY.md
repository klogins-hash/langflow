# 🚀 Deploy Your Custom Langflow to Railway

This is your personal fork of Langflow with full code control.

**Your Fork**: https://github.com/klogins-hash/langflow

## Quick Deploy (5 Minutes)

### Step 1: Go to Railway
Visit: https://railway.app/new

### Step 2: Deploy from GitHub
1. Click **"Deploy from GitHub repo"**
2. Select **`klogins-hash/langflow`**
3. Railway will auto-detect the `Dockerfile`

### Step 3: Configure Environment Variables

Add these in Railway dashboard → Variables:

```bash
LANGFLOW_DATABASE_URL=sqlite:////app/data/.cache/langflow/langflow.db
LANGFLOW_HOST=0.0.0.0
LANGFLOW_PORT=$PORT
LANGFLOW_LOG_LEVEL=INFO
LANGFLOW_AUTO_LOGIN=false
```

### Step 4: Add Persistent Storage

1. Go to your service → Settings → Volumes
2. Click **"New Volume"**
3. Mount path: `/app/data`
4. This persists your database and flows between deployments

### Step 5: Generate Domain

1. Settings → Networking
2. Click **"Generate Domain"**
3. Copy your URL (e.g., `your-langflow.up.railway.app`)

### Step 6: Get Your API Key

1. Open your Langflow URL in browser
2. Go to Settings → API Keys
3. Generate a new key
4. Save it for your Python client

## ✨ Customize Your Langflow

You now have full control! Edit anything:

### Add Custom Components

```bash
cd /Users/franksimpson/CascadeProjects/langflow-custom

# Create custom component
vim src/backend/langflow/components/custom/my_component.py
```

Example:
```python
from langflow.custom import Component
from langflow.io import MessageTextInput, Output

class MyCustomComponent(Component):
    display_name = "My Custom Component"
    description = "Does something custom"
    
    inputs = [
        MessageTextInput(name="input_text", display_name="Input")
    ]
    
    outputs = [
        Output(display_name="Output", name="output", method="process")
    ]
    
    def process(self) -> str:
        return f"Processed: {self.input_text}"
```

### Modify API Endpoints

Edit: `src/backend/langflow/api/`

### Customize UI

Edit: `src/frontend/`

## 🔄 Deploy Changes

```bash
# Make your changes
git add .
git commit -m "Add custom feature"
git push

# Railway automatically rebuilds and deploys!
```

## 📱 Update Your Python Client

```bash
cd /Users/franksimpson/CascadeProjects/langflow-project
```

Edit `.env`:
```bash
LANGFLOW_API_KEY=your-new-api-key-from-railway
LANGFLOW_URL=https://your-langflow.up.railway.app/
```

Test:
```bash
source venv/bin/activate
python test_connection.py
python example_usage.py
```

## 🎯 What's Next?

1. **Deploy to Railway** (follow steps above)
2. **Create your first flow** in the UI
3. **Customize Langflow** to your needs
4. **Build amazing AI apps!**

## 🔗 Resources

- **Your Fork**: https://github.com/klogins-hash/langflow
- **Railway Dashboard**: https://railway.app/dashboard
- **Langflow Docs**: https://docs.langflow.org/
- **Python Client**: `/Users/franksimpson/CascadeProjects/langflow-project/`

---

**You're ready to deploy! 🚀**
