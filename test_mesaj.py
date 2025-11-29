import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Firebase Linkin
FIREBASE_URL = "https://yemekapp-86251-default-rtdb.europe-west1.firebasedatabase.app/"

# Eğer daha önce bağlandıysa hata vermesin diye kontrol ediyoruz
if not firebase_admin._apps:
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_admin.initialize_app(cred, {'databaseURL': FIREBASE_URL})

ref = db.reference('gunluk_menu')
ref.set({
    'yemek': "Test: Noname Kebabı, Talha çorbası",
    'detay': " Kıymalı yağ yemeği, Metin giriniz Kebabı, Bisküvi çorbası",
    'tarih': "Test Tarihi"
})

print("🚀 Test mesajı gönderildi!")