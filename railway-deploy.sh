#!/bin/bash
# Railway deployment helper script

set -e

echo "🚂 Langflow Railway Deployment Helper"
echo "======================================"
echo ""

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI is not installed."
    echo ""
    echo "Install it with:"
    echo "  npm i -g @railway/cli"
    echo ""
    echo "Or use Homebrew:"
    echo "  brew install railway"
    exit 1
fi

echo "✅ Railway CLI is installed"
echo ""

# Check if logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 You need to login to Railway"
    railway login
fi

echo "✅ Logged in to Railway"
echo ""

# Check if project is linked
if ! railway status &> /dev/null; then
    echo "📦 No Railway project linked. Creating new project..."
    railway init
else
    echo "✅ Railway project already linked"
fi

echo ""
echo "🚀 Deploying to Railway..."
echo ""

# Deploy
railway up

echo ""
echo "✅ Deployment initiated!"
echo ""
echo "Next steps:"
echo "1. Add PostgreSQL database (recommended):"
echo "   railway add postgresql"
echo ""
echo "2. Set environment variables in Railway dashboard:"
echo "   - LANGFLOW_SUPERUSER"
echo "   - LANGFLOW_SUPERUSER_PASSWORD"
echo ""
echo "3. View logs:"
echo "   railway logs"
echo ""
echo "4. Open your deployment:"
echo "   railway open"
echo ""
