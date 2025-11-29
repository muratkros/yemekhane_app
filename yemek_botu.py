import pandas as pd
from datetime import datetime
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db


DOSYA_ADI = "yemek_listesi.xlsx"
FIREBASE_URL = "https://yemekapp-86251-default-rtdb.europe-west1.firebasedatabase.app/"

if not firebase_admin._apps:
    cred = credentials.Certificate("serviceAccountKey.json")
    firebase_admin.initialize_app(cred, {'databaseURL': FIREBASE_URL})

def sistemi_calistir():
    try:
        bugun_tam = datetime.now()
        haftanin_gunu = bugun_tam.weekday()
        bugun_tarih_str = bugun_tam.strftime('%Y-%m-%d')

        
        if haftanin_gunu == 5 or haftanin_gunu == 6:
            print("Bugün hafta sonu. Excel okunmayacak.")
            mesaj = "Hafta sonu yemek çıkmıyor Reis, iyi tatiller!"
            
           
            db.reference('gunluk_menu').set({
                'yemek': "Hafta Sonu",
                'detay': mesaj,
                'tarih': bugun_tarih_str
            })
            print("🚀 Uygulamaya 'Hafta Sonu' bilgisi gönderildi.")
            return

       
        print("Bugün hafta içi, Excel okunuyor...")
        df = pd.read_excel(DOSYA_ADI)
        df['Tarih'] = pd.to_datetime(df['Tarih'], format='%d.%m.%Y')
        
        bugun_sifir = bugun_tam.replace(hour=0, minute=0, second=0, microsecond=0)
        sonuc = df[df['Tarih'] == bugun_sifir]

        if not sonuc.empty:
            yemek_listesi = sonuc.iloc[0]['Yemekler']
            print(f"✅ Menü Bulundu: {yemek_listesi}")
            
            
            db.reference('gunluk_menu').set({
                'yemek': "Günün Menüsü",
                'detay': yemek_listesi,
                'tarih': bugun_tarih_str
            })
            print("🚀 Veri başarıyla buluta yollandı!")
        else:
            print("❌ Excel'de bugünün tarihine ait veri yok.")
            

    except Exception as e:
        print(f"❌ HATA OLUŞTU: {e}")

if __name__ == "__main__":
    sistemi_calistir()