#!/bin/bash

# 📤 سكريبت رفع جميع المشاريع إلى GitHub
echo "🚀 رفع جميع مشاريع صيدلية هشام إلى GitHub"
echo "============================================"

# الألوان
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# التحقق من المجلد
DEPLOY_DIR="hisham-pharmacy-deploy"
if [ ! -d "$DEPLOY_DIR" ]; then
    echo -e "${RED}❌ المجلد $DEPLOY_DIR غير موجود!${NC}"
    echo -e "${YELLOW}💡 قم بتشغيل deploy.sh أولاً${NC}"
    exit 1
fi

cd $DEPLOY_DIR

repositories=("hisham-customer" "hisham-admin" "hisham-api" "hisham-assets")
repo_names=("hisham-pharmacy-customer" "hisham-pharmacy-admin" "hisham-pharmacy-api" "hisham-pharmacy-assets")

echo -e "${BLUE}📋 سيتم رفع المشاريع التالية:${NC}"
for i in "${!repositories[@]}"; do
    echo "  $((i+1)). ${repo_names[$i]}"
done
echo

read -p "هل تريد المتابعة؟ (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}تم الإلغاء${NC}"
    exit 0
fi

echo -e "${GREEN}🚀 بدء الرفع...${NC}"
echo

for i in "${!repositories[@]}"; do
    dir=${repositories[$i]}
    repo_name=${repo_names[$i]}
    
    echo -e "${BLUE}📤 رفع $repo_name...${NC}"
    
    cd $dir
    
    # التحقق من وجود تغييرات
    if git status --porcelain | grep -q .; then
        echo -e "${YELLOW}📝 يوجد تغييرات جديدة، جاري commit...${NC}"
        git add .
        git commit -m "🔄 Update $(date '+%Y-%m-%d %H:%M')"
    fi
    
    # محاولة Push
    if git push -u origin main 2>/dev/null; then
        echo -e "${GREEN}✅ تم رفع $repo_name بنجاح${NC}"
    else
        echo -e "${RED}❌ فشل في رفع $repo_name${NC}"
        echo -e "${YELLOW}💡 تأكد من إنشاء repository على GitHub: https://github.com/new${NC}"
        echo -e "${YELLOW}💡 اسم Repository: $repo_name${NC}"
        
        read -p "هل تريد المحاولة مرة أخرى؟ (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if git push -u origin main; then
                echo -e "${GREEN}✅ تم رفع $repo_name بنجاح${NC}"
            else
                echo -e "${RED}❌ فشل مرة أخرى${NC}"
            fi
        fi
    fi
    
    echo "---"
    cd ..
done

echo -e "${GREEN}🎉 انتهى رفع المشاريع!${NC}"
echo

# عرض الروابط المحتملة
echo -e "${BLUE}🌐 روابطك المحتملة:${NC}"
echo "🛒 العملاء: https://[username].github.io/hisham-pharmacy-customer"
echo "⚙️  الإدارة: https://[username].github.io/hisham-pharmacy-admin" 
echo "📷 الصور: https://[username].github.io/hisham-pharmacy-assets"
echo "🔄 API: https://hisham-pharmacy-api.vercel.app (يحتاج ربط مع Vercel)"
echo

echo -e "${YELLOW}📋 الخطوات التالية:${NC}"
echo "1. اذهب إلى https://netlify.com وسجل دخول"
echo "2. اربط 3 repositories (Customer, Admin, Assets)"
echo "3. اذهب إلى https://vercel.com واربط API repository"
echo "4. فعل GitHub Pages في إعدادات كل repository"

cd ..