#!/bin/bash

# Название файла для Python скрипта
PYTHON_SCRIPT_NAME="request_script.py"

# Проверка, установлен ли Python, и установка, если он не установлен
if ! command -v python3 &> /dev/null
then
    echo "Python3 не найден, устанавливаем..."
    sudo apt update
    sudo apt install python3 python3-pip -y
else
    echo "Python3 уже установлен"
fi

# Установка библиотеки requests, если она не установлена
pip3 show requests &> /dev/null
if [ $? -ne 0 ]; then
    echo "Библиотека requests не найдена, устанавливаем..."
    pip3 install requests
else
    echo "Библиотека requests уже установлена"
fi

# Создание Python скрипта
echo "Создаем Python скрипт..."
cat << EOF > $PYTHON_SCRIPT_NAME
import requests
import time
import random
import logging

# Настройка логирования для вывода в консоль
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(message)s")

# URL и заголовки для запроса
url = input("Введите URL для отправки запроса: ")
headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
}

# 100 вопросов для рандомизации
questions = [
    "Where is Berlin?", "What is the capital of USA?", "How far is the moon from the Jupiter?",
    "Who singed 'Mockingbird'?", "What is the lenght of red spectr?", "How many lakes are Earth?",
    "What is the smallest mountain in the asia?", "Who painted the Mickeladjello?", "What is the largest sea on USA?",
    "How many sputniks are of Saturn?", "What is the footbal capital of Great Britain?", "Who discovered New Light and Australia?",
    "What is the broadest river in the world?", "Who is the last president of the US?",
    "What is the sweetest desert in the world?", "How many NBA clubs are there in the USA?", "What is the largest country in the world?",
    "Who was the first cosmonaut in the world?", "What is the chemical symbol for silver?", "What is the highest mountain in the USA?",
    "What is the second capital of Russia?", "Who wrote 'Harry Potter'?", "What is the smallest continent?", "Who developed the theory of nuclear bomb?",
    "What is the fastest bird?", "How many bones are in the colibri?", "What is the largest half island in the world?",
    "What is the most popular language in Canada?", "What is the capital of California?", "Who invented the chemistry table?",
    "What is the national currency of ElSalvador?", "What is the most famous person of Russia?", "What is the longest mountain line in the world?",
    "What is the most small country in the world?", "What is the currency of Argentina?", "What is the largest economical debt in nations history?",
    "Who wrote 'Romeo and Jullietta'?", "What is the most deep sea in the world?", "What is the current president of India?",
    "Who painted the Van Gog portrait?", "What is the tight hole in the body?", "What is the fotball championat of Brazil?",
    "What is the highest tree in North America?", "What is the CDP of China?", "Who wrote 'Eragon'?",
    "What is the deepest lake trench?", "What is the richest person of Mexico?", "What was the war in North America?",
    "What is the footbal ticker of Real Sosiedad?", "What is the biggest coral system in four oceans?", "Who is known as the mother of physics?",
    "What is the economic problems of Argentina?", "What is the smallest by popularity country?", "Who invented the clock?",
    "What is the highest mountain in South Africa?", "What is the capitals of Sweden and Norway?", "Who wrote the first roman?",
    "What is the power of light?", "What is the largest city in the Europe?", "What is the capital and currency of Indonesia?",
    "Who wrote and released 'Witcher'?", "What is the coldest place on US?", "What is the currency of UAE?",
    "Who is the producer of 'Avatar'?", "What is the highest building in the Germany?", "What is the currency of Italy?",
    "Who researched the atom?", "What is the smallest planet in the Milky Way?", "What is the nation of Canada?",
    "Who is the producer 'The Great Gatsby'?", "What is the oldest nation in Africa?", "What is the money in Turkey?",
    "Who invented the radio and phone?", "What is the largest sputnik in the world?", "What is the seas in Indonesia?",
    "Who painted 'The Last Shot'?", "What is the weather in Athens?", "Who developed the coronavirus stamm?",
    "What is the population of Vietnam?", "What is the most large currency in the world?", "What is the border of Iran?",
    "Who painted 'The Odyssey'?", "What is the politics of Portugal?", "Who invented the motorcycle?",
    "What is the largest area in the world by population?", "What is the treasury of Norway in US dollars?", "Who wrote 'Market cycles'?",
    "What is the larges lake in South Half of Earth?", "What is the CDP of Sweden?", "Who discovered Saturn?",
    "What is the most fastest city now in the world?", "What is the central area of Africa?", "Who wrote '451 by Farengate'?",
    "What is the largest river by length and wide?", "What is the capital of Venezuaela?", "Who invented the iphone?",
    "What are the capitals of Iran and Israel?", "What is the most widely used programming language in Web3?", "What is the national currency of Egypt?",
    "Who wrote 'Save life'?", "What is the sea in Malaysia?", "Who painted 'Girl with peaches'?"
]

# Функция для отправки запроса
def send_request():
    # Выбираем случайный вопрос
    question = random.choice(questions)
    # Формируем тело запроса
    data = {
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": question}
        ]
    }
    logging.info(f"Отправка запроса с вопросом: {question}")
    response = requests.post(url, headers=headers, json=data)
    if response.status_code == 200:
        logging.info(f"Ответ: {response.json()}")
    else:
        logging.error(f"Ошибка получения ответа, статус-код: {response.status_code}")

# Основной цикл
def main():
    sleep_hours = 8  # Часы для сна
    sleep_seconds = sleep_hours * 3600  # Перевод в секунды

    while True:
        # Определяем случайное количество запросов перед длинным перерывом
        num_requests = random.randint(6, 12)  # От 6 до 12 запросов (в среднем около часа)

        for _ in range(num_requests):
            send_request()
            # Случайная задержка между запросами от 1 до 5 минут
            delay = random.randint(60, 300)
            logging.info(f"Ожидание {delay // 60} минут...")
            time.sleep(delay)

        # Длинный перерыв от 30 минут до 1 часа
        long_break = random.randint(1800, 3600)
        logging.info(f"Перерыв на {long_break // 60} минут...")
        time.sleep(long_break)

        # Перерыв на сон каждые 24 часа
        logging.info(f"Сон на {sleep_hours} часов...")
        time.sleep(sleep_seconds)

if __name__ == "__main__":
    main()
EOF

# Установка screen, если не установлен
if ! command -v screen &> /dev/null
then
    echo "screen не найден, устанавливаем..."
    sudo apt install screen -y
else
    echo "screen уже установлен"
fi

# Запуск Python скрипта в фоновом режиме через screen
screen -dmS python_script_session bash -c "python3 $PYTHON_SCRIPT_NAME | tee -a request_script.log"

echo "Скрипт $PYTHON_SCRIPT_NAME запущен в фоновом режиме через screen."
echo "Чтобы подключиться к сессии screen и посмотреть логи, используйте команду: screen -r python_script_session"
