#!/bin/bash

# 🚀 سكريبت النشر التلقائي - صيدلية هشام
# هذا السكريبت ينشئ 4 مجلدات منفصلة ويرفعهم على GitHub

echo "🏥 مرحباً بك في منصة نشر صيدلية هشام"
echo "=========================================="

# ألوان للنص
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # بدون لون

# التحقق من وجود git
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git غير مثبت. يرجى تثبيت Git أولاً${NC}"
    exit 1
fi

echo -e "${BLUE}📝 يرجى إدخال اسم المستخدم في GitHub:${NC}"
read -p "Username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo -e "${RED}❌ يجب إدخال اسم المستخدم${NC}"
    exit 1
fi

echo -e "${GREEN}✅ جاري إعداد المشروع للنشر...${NC}"

# إنشاء مجلد للنشر
DEPLOY_DIR="hisham-pharmacy-deploy"
mkdir -p $DEPLOY_DIR
cd $DEPLOY_DIR

echo -e "${YELLOW}🔨 إنشاء المواقع الأربعة...${NC}"

# ===== 1. الموقع الرئيسي للعملاء =====
echo -e "${BLUE}1️⃣ إعداد الموقع الرئيسي...${NC}"
mkdir -p hisham-customer
cp ../index.html ../style.css ../app.js ../api.js hisham-customer/

# إنشاء README للموقع الرئيسي
cat > hisham-customer/README.md << EOL
# 💊 صيدلية هشام - الموقع الرئيسي

الموقع الرئيسي للعملاء لتصفح المنتجات وإجراء الطلبات.

## 🌐 الرابط المباشر
\`\`\`
https://$GITHUB_USERNAME.github.io/hisham-pharmacy-customer
\`\`\`

## 📱 المميزات
- تصفح المنتجات
- البحث والتصنيف
- سلة التسوق
- تحديد الموقع الجغرافي
- الطلب عبر واتساب
- الشات بوت الذكي
- الوضع المظلم

## 🔄 التحديث
أي تغيير في هذا Repository سيؤدي إلى تحديث الموقع تلقائياً.

---
تم إنشاؤه بواسطة سكريبت النشر التلقائي 🚀
EOL

# ===== 2. لوحة التحكم للإدارة =====
echo -e "${BLUE}2️⃣ إعداد لوحة التحكم...${NC}"
mkdir -p hisham-admin

# إنشاء ملف HTML منفصل للوحة التحكم
cat > hisham-admin/index.html << EOL
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة التحكم - صيدلية هشام</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body class="admin-body">
    <!-- تحويل محتوى admin.html هنا -->
    <script>
        // تحويل المستخدم إلى admin.html
        window.location.href = 'admin.html';
    </script>
    
    <div style="text-align: center; padding: 2rem; font-family: Cairo;">
        <h1>🔄 جاري التحويل إلى لوحة التحكم...</h1>
        <p>إذا لم يتم التحويل تلقائياً، <a href="admin.html">اضغط هنا</a></p>
    </div>
</body>
</html>
EOL

cp ../admin.html ../style.css ../admin.js ../api.js hisham-admin/

cat > hisham-admin/README.md << EOL
# ⚙️ صيدلية هشام - لوحة التحكم

لوحة التحكم الخاصة بالدكتور هشام لإدارة الصيدلية.

## 🔐 بيانات الدخول
- **اسم المستخدم:** \`admin\`
- **كلمة المرور:** \`hisham123\`

## 🌐 الرابط المباشر
\`\`\`
https://$GITHUB_USERNAME.github.io/hisham-pharmacy-admin
\`\`\`

## 🛠 المميزات
- إدارة المنتجات (إضافة/تعديل/حذف)
- متابعة الطلبات وتحديث حالتها
- حذف الطلبات المكتملة
- إحصائيات شاملة
- تغيير كلمة المرور
- الوضع المظلم

## 🔄 التزامن
تتزامن البيانات تلقائياً مع الموقع الرئيسي للعملاء.

---
تم إنشاؤه بواسطة سكريبت النشر التلقائي 🚀
EOL

# ===== 3. API البيانات =====
echo -e "${BLUE}3️⃣ إعداد API البيانات...${NC}"
mkdir -p hisham-api

# إنشاء ملف Vercel configuration
cat > hisham-api/vercel.json << EOL
{
  "version": 2,
  "builds": [
    {
      "src": "*.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/api.js"
    }
  ]
}
EOL

# إنشاء API endpoint
cat > hisham-api/api.js << EOL
// API للبيانات المشتركة - Vercel Serverless Function
export default function handler(req, res) {
    // إعداد CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    const { method, url } = req;
    
    // Routes
    if (url === '/medicines' && method === 'GET') {
        // جلب الأدوية - يمكن ربطه بقاعدة بيانات لاحقاً
        res.status(200).json([
            { id: 1, name: "بانادول", category: "مسكنات", price: 25, available: true }
        ]);
    } else if (url === '/orders' && method === 'GET') {
        // جلب الطلبات
        res.status(200).json([]);
    } else if (url === '/last-update' && method === 'GET') {
        // آخر تحديث
        res.status(200).json({
            timestamp: Date.now(),
            version: '1.0.0'
        });
    } else {
        res.status(404).json({ error: 'Not found' });
    }
}
EOL

cp ../api.js hisham-api/client-api.js

cat > hisham-api/README.md << EOL
# 🔄 صيدلية هشام - API البيانات

خادم API لمزامنة البيانات بين الموقع الرئيسي ولوحة التحكم.

## 🌐 الرابط المباشر
\`\`\`
https://hisham-pharmacy-api.vercel.app
\`\`\`

## 📡 Endpoints
- \`GET /medicines\` - جلب جميع الأدوية
- \`GET /orders\` - جلب جميع الطلبات
- \`GET /last-update\` - آخر تحديث

## 🚀 النشر
يتم النشر تلقائياً على Vercel عند Push إلى GitHub.

---
تم إنشاؤه بواسطة سكريبت النشر التلقائي 🚀
EOL

# ===== 4. الصور والملفات =====
echo -e "${BLUE}4️⃣ إعداد مجلد الصور...${NC}"
mkdir -p hisham-assets/images
mkdir -p hisham-assets/docs

# نسخ الصور إن وجدت
if [ -d "../images" ]; then
    cp -r ../images/* hisham-assets/images/ 2>/dev/null || true
fi

# إنشاء صور افتراضية
cat > hisham-assets/create-placeholder.html << EOL
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إنشاء صور افتراضية</title>
</head>
<body>
    <h1>📷 معرض الصور - صيدلية هشام</h1>
    <script>
        // إنشاء صور افتراضية باستخدام Canvas
        const medicines = [
            'بانادول', 'فيتامين سي', 'أدفيل', 'كولد فري',
            'أوميجا 3', 'بيبانثين', 'شراب السعال'
        ];
        
        medicines.forEach(name => {
            const canvas = document.createElement('canvas');
            canvas.width = 200;
            canvas.height = 200;
            const ctx = canvas.getContext('2d');
            
            // خلفية ملونة
            ctx.fillStyle = '#f0f8ff';
            ctx.fillRect(0, 0, 200, 200);
            
            // نص
            ctx.fillStyle = '#333';
            ctx.font = '16px Arial';
            ctx.textAlign = 'center';
            ctx.fillText(name, 100, 100);
            
            // تحويل إلى صورة وحفظ
            const link = document.createElement('a');
            link.download = name + '.png';
            link.href = canvas.toDataURL();
            document.body.appendChild(link);
        });
    </script>
</body>
</html>
EOL

cat > hisham-assets/README.md << EOL
# 📷 صيدلية هشام - الصور والملفات

مجلد لتخزين صور المنتجات والملفات الثابتة.

## 🌐 الرابط المباشر
\`\`\`
https://$GITHUB_USERNAME.github.io/hisham-pharmacy-assets
\`\`\`

## 📂 المحتويات
- \`images/\` - صور المنتجات
- \`docs/\` - المستندات والملفات
- \`uploads/\` - الملفات المرفوعة

## 📤 رفع الملفات
يمكن رفع الملفات عبر GitHub أو أدوات Git.

---
تم إنشاؤه بواسطة سكريپت النشر التلقائي 🚀
EOL

# ===== إنشاء Git Repositories =====
echo -e "${YELLOW}🔗 إنشاء Git Repositories...${NC}"

repositories=("hisham-customer" "hisham-admin" "hisham-api" "hisham-assets")
repo_names=("hisham-pharmacy-customer" "hisham-pharmacy-admin" "hisham-pharmacy-api" "hisham-pharmacy-assets")

for i in "${!repositories[@]}"; do
    dir=${repositories[$i]}
    repo_name=${repo_names[$i]}
    
    echo -e "${BLUE}📦 إعداد $dir...${NC}"
    
    cd $dir
    
    # Git initialization
    git init
    git add .
    git commit -m "🚀 Initial deployment for Hisham Pharmacy"
    git branch -M main
    
    # إضافة remote
    git remote add origin "https://github.com/$GITHUB_USERNAME/$repo_name.git"
    
    echo -e "${GREEN}✅ تم إعداد $dir${NC}"
    echo -e "${YELLOW}📝 قم بإنشاء repository على GitHub: https://github.com/new${NC}"
    echo -e "${YELLOW}📝 اسم Repository: $repo_name${NC}"
    echo -e "${YELLOW}📝 ثم قم بتشغيل: git push -u origin main${NC}"
    echo "---"
    
    cd ..
done

echo -e "${GREEN}🎉 تم إنشاء جميع الملفات بنجاح!${NC}"
echo -e "${GREEN}📁 الملفات موجودة في: $(pwd)${NC}"
echo ""
echo -e "${BLUE}📋 الخطوات التالية:${NC}"
echo "1. أنشئ 4 repositories على GitHub بالأسماء المذكورة أعلاه"
echo "2. ادخل كل مجلد وقم بتشغيل: git push -u origin main"
echo "3. اذهب إلى Netlify وربط 3 repositories (عدا API)"
echo "4. اذهب إلى Vercel وربط API repository"
echo ""
echo -e "${GREEN}🌐 روابطك ستكون:${NC}"
echo "🛒 العملاء: https://$GITHUB_USERNAME.github.io/hisham-pharmacy-customer"
echo "⚙️  الإدارة: https://$GITHUB_USERNAME.github.io/hisham-pharmacy-admin"
echo "🔄 API: https://hisham-pharmacy-api.vercel.app"
echo "📷 الصور: https://$GITHUB_USERNAME.github.io/hisham-pharmacy-assets"
echo ""
echo -e "${GREEN}💡 نصيحة: احفظ هذه الروابط في مكان آمن!${NC}"

cd ..