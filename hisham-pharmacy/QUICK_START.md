# 🚀 دليل النشر السريع - صيدلية هشام

## ⚡ النشر في 5 دقائق

### الخطوة 1: تشغيل السكريبت
```bash
# اجعل الملفات قابلة للتشغيل
chmod +x deploy.sh push-all.sh

# شغل سكريبت النشر
./deploy.sh
```

### الخطوة 2: إنشاء Repositories على GitHub
اذهب إلى [GitHub](https://github.com/new) وأنشئ 4 repositories:

1. **hisham-pharmacy-customer** (عام/خاص)
2. **hisham-pharmacy-admin** (خاص مُوصى به)  
3. **hisham-pharmacy-api** (خاص)
4. **hisham-pharmacy-assets** (عام)

### الخطوة 3: رفع الملفات
```bash
# رفع جميع المشاريع
./push-all.sh
```

### الخطوة 4: ربط المنصات

#### أ) GitHub Pages (مجاني)
لكل repository:
1. اذهب إلى **Settings → Pages**
2. اختر **Deploy from a branch**
3. اختر **main branch**
4. احفظ

#### ب) Netlify (أفضل - مجاني)
1. اذهب إلى [netlify.com](https://netlify.com)
2. **Import from Git → GitHub**
3. اختر repositories:
   - `hisham-pharmacy-customer`
   - `hisham-pharmacy-admin` 
   - `hisham-pharmacy-assets`

#### ج) Vercel للـ API
1. اذهب إلى [vercel.com](https://vercel.com)
2. **Import Project → GitHub**
3. اختر `hisham-pharmacy-api`

---

## 🌐 روابطك بعد النشر

### GitHub Pages
```
🛒 العملاء: https://[username].github.io/hisham-pharmacy-customer
⚙️ الإدارة: https://[username].github.io/hisham-pharmacy-admin
📷 الصور: https://[username].github.io/hisham-pharmacy-assets
```

### Netlify (روابط تلقائية)
```
🛒 العملاء: https://[random-name].netlify.app
⚙️ الإدارة: https://[random-name].netlify.app
📷 الصور: https://[random-name].netlify.app
```

### Vercel
```
🔄 API: https://hisham-pharmacy-api.vercel.app
```

---

## 🔧 تخصيص الدومين (اختياري)

### دومين مجاني من Freenom
1. اذهب إلى [freenom.com](https://freenom.com)
2. ابحث عن دومين مجاني (.tk, .ml, .ga, .cf)
3. سجل الدومين

### ربط الدومين
#### مع Netlify:
1. **Site Settings → Domain Management**
2. **Add Custom Domain**
3. اتبع التعليمات

#### مع GitHub Pages:
1. **Settings → Pages → Custom Domain**
2. أدخل الدومين واحفظ

---

## 📧 إيميل مجاني

### خيار 1: Gmail + Alias
```
البريد: hisham.pharmacy@gmail.com
Alias: orders@hisham.pharmacy (إعادة توجيه)
```

### خيار 2: ProtonMail
```
مجاني: hisham.pharmacy@protonmail.com
```

---

## 🔄 التحديثات التلقائية

كل تغيير في GitHub سيؤدي إلى:
✅ تحديث فوري على Netlify/Vercel  
✅ مزامنة تلقائية بين المواقع  
✅ إشعار العملاء بالتحديثات الجديدة  

---

## 🆘 استكشاف الأخطاء

### مشكلة: فشل Git Push
```bash
# تحقق من remote
git remote -v

# إعادة إضافة
git remote set-url origin https://github.com/[username]/[repo-name].git
```

### مشكلة: الموقع لا يعمل
1. تحقق من **GitHub Pages Settings**
2. انتظر 5-10 دقائق للنشر
3. تحقق من **Actions** للأخطاء

### مشكلة: API لا يعمل
1. تحقق من **Vercel Functions**
2. اقرأ **Function Logs**

---

## 📞 الدعم

### بيانات الدخول الافتراضية:
- **المستخدم:** `admin`
- **كلمة المرور:** `hisham123`

### الملفات المهمة:
- `api.js` - مزامنة البيانات
- `DEPLOYMENT_GUIDE.md` - الدليل الشامل
- `deploy.sh` - سكريبت النشر
- `push-all.sh` - رفع المشاريع

---

## 🎉 تهانينا!

موقعك أصبح جاهزاً على الإنترنت مجاناً! 🚀

**روابط مفيدة:**
- [GitHub](https://github.com) - رفع الكود
- [Netlify](https://netlify.com) - استضافة المواقع  
- [Vercel](https://vercel.com) - استضافة API
- [Freenom](https://freenom.com) - دومين مجاني