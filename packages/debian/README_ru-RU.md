## Создание и установка .deb-пакета

### 1. Клонируйте репозиторий
```bash
git clone https://github.com/AeEn123/RoExtract
```

### 2. Сделайте `build_deb.sh` исполняемым
```bash
cd RoExtract
chmod +x packages/debian/build_deb.sh
```

### 3. Запустите скрипт
```bash
bash packages/debian/build_deb.sh
```

## Пакет будет собран и установлен автоматически.
