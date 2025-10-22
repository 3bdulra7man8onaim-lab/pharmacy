// ===== API بسيط لمشاركة البيانات بين المواقع =====

class PharmacyAPI {
    constructor() {
        this.baseURL = 'https://hisham-api.vercel.app'; // سيتم تحديث الرابط
        this.localAPI = true; // للتشغيل المحلي
    }

    // ===== الأدوية =====
    
    // جلب جميع الأدوية
    async getMedicines() {
        if (this.localAPI) {
            const savedMedicines = localStorage.getItem('hisham_medicines');
            return savedMedicines ? JSON.parse(savedMedicines) : [];
        }
        
        try {
            const response = await fetch(`${this.baseURL}/medicines`);
            return await response.json();
        } catch (error) {
            console.error('خطأ في جلب الأدوية:', error);
            return [];
        }
    }

    // حفظ الأدوية
    async saveMedicines(medicines) {
        if (this.localAPI) {
            localStorage.setItem('hisham_medicines', JSON.stringify(medicines));
            // إرسال إشعار للمواقع الأخرى
            this.broadcastUpdate('medicines', medicines);
            return { success: true };
        }
        
        try {
            const response = await fetch(`${this.baseURL}/medicines`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(medicines)
            });
            return await response.json();
        } catch (error) {
            console.error('خطأ في حفظ الأدوية:', error);
            return { success: false, error };
        }
    }

    // ===== الطلبات =====
    
    // جلب جميع الطلبات
    async getOrders() {
        if (this.localAPI) {
            const savedOrders = localStorage.getItem('hisham_orders');
            return savedOrders ? JSON.parse(savedOrders) : [];
        }
        
        try {
            const response = await fetch(`${this.baseURL}/orders`);
            return await response.json();
        } catch (error) {
            console.error('خطأ في جلب الطلبات:', error);
            return [];
        }
    }

    // حفظ الطلبات
    async saveOrders(orders) {
        if (this.localAPI) {
            localStorage.setItem('hisham_orders', JSON.stringify(orders));
            this.broadcastUpdate('orders', orders);
            return { success: true };
        }
        
        try {
            const response = await fetch(`${this.baseURL}/orders`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(orders)
            });
            return await response.json();
        } catch (error) {
            console.error('خطأ في حفظ الطلبات:', error);
            return { success: false, error };
        }
    }

    // إضافة طلب جديد
    async addOrder(order) {
        const orders = await this.getOrders();
        orders.push(order);
        return await this.saveOrders(orders);
    }

    // ===== المزامنة المباشرة =====
    
    // إرسال إشعار تحديث للمواقع الأخرى
    broadcastUpdate(type, data) {
        // استخدام BroadcastChannel للتحديث المباشر
        if ('BroadcastChannel' in window) {
            const channel = new BroadcastChannel('hisham-pharmacy-updates');
            channel.postMessage({
                type: type,
                data: data,
                timestamp: Date.now()
            });
        }
        
        // حفظ آخر تحديث
        localStorage.setItem('hisham_last_update', JSON.stringify({
            type: type,
            timestamp: Date.now()
        }));
    }

    // استقبال التحديثات
    onUpdate(callback) {
        if ('BroadcastChannel' in window) {
            const channel = new BroadcastChannel('hisham-pharmacy-updates');
            channel.addEventListener('message', (event) => {
                callback(event.data);
            });
        }
    }

    // مزامنة مع الخادم (للتشغيل المتقدم)
    async syncWithServer() {
        if (this.localAPI) return;
        
        try {
            // جلب آخر تحديث من الخادم
            const response = await fetch(`${this.baseURL}/last-update`);
            const serverUpdate = await response.json();
            
            const localUpdate = JSON.parse(localStorage.getItem('hisham_last_update') || '{}');
            
            // إذا كان الخادم محدث أكثر، جلب البيانات
            if (serverUpdate.timestamp > (localUpdate.timestamp || 0)) {
                const medicines = await this.getMedicines();
                const orders = await this.getOrders();
                
                // تحديث البيانات المحلية
                localStorage.setItem('hisham_medicines', JSON.stringify(medicines));
                localStorage.setItem('hisham_orders', JSON.stringify(orders));
                
                return { updated: true, medicines, orders };
            }
            
            return { updated: false };
        } catch (error) {
            console.error('خطأ في المزامنة:', error);
            return { updated: false, error };
        }
    }

    // ===== وظائف مساعدة =====
    
    // تحديث حالة طلب
    async updateOrderStatus(orderId, status) {
        const orders = await this.getOrders();
        const orderIndex = orders.findIndex(o => o.id === orderId);
        
        if (orderIndex !== -1) {
            orders[orderIndex].status = status;
            orders[orderIndex].updatedAt = new Date().toLocaleString('ar-EG');
            return await this.saveOrders(orders);
        }
        
        return { success: false, message: 'الطلب غير موجود' };
    }

    // حذف طلب
    async deleteOrder(orderId) {
        const orders = await this.getOrders();
        const filteredOrders = orders.filter(o => o.id !== orderId);
        return await this.saveOrders(filteredOrders);
    }

    // إضافة/تحديث منتج
    async updateMedicine(medicine) {
        const medicines = await this.getMedicines();
        const existingIndex = medicines.findIndex(m => m.id === medicine.id);
        
        if (existingIndex !== -1) {
            medicines[existingIndex] = medicine;
        } else {
            medicine.id = Date.now();
            medicines.push(medicine);
        }
        
        return await this.saveMedicines(medicines);
    }

    // حذف منتج
    async deleteMedicine(medicineId) {
        const medicines = await this.getMedicines();
        const filteredMedicines = medicines.filter(m => m.id !== medicineId);
        return await this.saveMedicines(filteredMedicines);
    }
}

// إنشاء instance عام
window.PharmacyAPI = new PharmacyAPI();

// تصدير للاستخدام في Node.js إذا لزم الأمر
if (typeof module !== 'undefined' && module.exports) {
    module.exports = PharmacyAPI;
}