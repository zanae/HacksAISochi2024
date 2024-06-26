# HacksAISochi2024
Примечание: редактирование readme не считается за редактирование кода.
ССЫЛКА НА НАШ ОБУЧЕННЫЙ НА ЦЕННИКАХ BERT https://drive.google.com/drive/folders/1HzOErdqw60BYXGfV1Fryp_fjlFYGNVE_?usp=sharing
GITHUB НЕ ПОЗВОЛЯЕТ ЗАГРУЗИТЬ ЕЁ, Т.К. ВЕСИТ 680 МБ, А НА ГИТХАБ ОГРАНИЧЕНИЕ 25 МБ. ОСТАЛЬНЫЕ 2 МОДЕЛИ ЗАГРУЖЕНЫ (cennic_detector.pt - обнаружение ценников на фото, даже на фото стеллажей; и prise_detector.pt - обнаружение цен)

Командный проект с хакатона Цифровой прорыв

Проект представляет из себя сервис по выявлению обработке нарушений в ценовой политике на социальные товары

Сервис состоит из 4 частей:
1. Модель анализа фотографий
2. API приложения для осуществления работы модели и хранения данных
3. Мобильное приложение для покупателей и продавцов
4. WEB приложение для сотрудников контролирующих органов

Стоит пояснить что помимо модели уровень реализации остальных компонентов системы находится на стадии настроенной инфраструктуры, но не представляет из себя рабочий продукт.

Далее подробно по каждному пункту:

# 1. Модель 

![Diagram](Assets/Model-diagram.drawio.svg)

В нашем решении использовались предобученная модель YOLOv8 Nano, дообученная на небольшом количестве фотографий ценников и стеллажей, предоставленные заказчиком, разметка проводилась вручную с использованием сервиса roboflow. Благодаря проведённой нами вручную разметке изображений, точность обнаружения, как правило, достигает 98%, несмотря на скудность датасета. Способна обнаруживать ценники на стеллажах (но не считывать и классифицировать их).
Для многоклассовой классификации была взята ruBERT, обучавшаяся на информации из файла train.csv, откуда брались тексты ценников и категории товаров для классификации.
Чтобы в принципе распознать написанное на ценниках, в частности, сами цены, использовалась OCR. 

Элементы, находящиеся в множестве Носимое устройство, могут быть внедрены в мобильное приложения для улучшения качества сбора данных.

# 2. API приложение

![Diagram](Assets/Archecture-diargam.svg)

Пояснения к диаграмме архитектуры: 
Стрелки означают поток данных, красные – низкоцелостные, зеленые – высокоцелостные
Красные компоненты – недоверенные
Желтые – повышающие доверие

![Diagram](Assets/DB-diagram.svg)

Пояснение к диаграмме бд:
Users – Данные пользователей, в том числе их роли(покупатель, продавец, админ)
Shops – Данные о магазинах( изменяются продавцами и админами)
Categories – Данные о максимально допустимых ценах на социальные товары по категориям(изменяются админами)
Issues – Данные о жалобах, вносятся пользователями
Problem_issues – Данные и статус подтвержденных моделью жалоб

Данные поступают из мобильного и web приложений в API интерфейс, далее передаются в компонент Аутентификация, в нем проверяется аутентичность отправителя по средствам дешифровки токена. Если этот этап прошел успешно данные отправляются в обработчик запросов, там в зависимости от типа запроса либо идет прямое взаимодействие с БД, которое так же осуществляется с использованием шифрования, либо если это данные пришедшие от покупателя, содержащие информацию о жалобе, они отправляются в обработчик данных, который в свою очередь передает их в модель, и на основании сравнения результата работы модели и данных из таблицы Categories определяет жалобу как необходимую к рассмотрению или ошибочную. Остальная логика работы приложения заключается в предоставлении, изменении, удалении данных из БД, в соответсвии с ролью пользователя.


# 3. Мобильное приложение

Действия с мобильным приложением делятся на два сценария – для покупателя и для продавца. Однако оба проходят через этап регистрации и аутентификации(роль продавца назначается админом). Так же оба имеют возможность изменить свои личные данные в настройках.

![Mobile](Assets/Mobile-Customer-1.png)
![Mobile](Assets/Mobile-Customer-2.png)

Покупатель может добавить фото в которых он увидел нарушение и выбрать на карте или из списка магазин где это произошло. Далее он отправляет эту информацию.

![Mobile](Assets/Mobile-Seller-1.png)
![Mobile](Assets/Mobile-Seller-2.png)
![Mobile](Assets/Mobile-Seller-3.png)

Продавец же видит подтвержденные жалобы пришедшие на адрес его магазина. Он может ознакомиться с ними и обжаловать если посчитает, что они некорректны( спор происходит по средствам email переписки). Если нарушение действительно имеет смысл быть, то продавец может исправить его и отправить подтверждение этого. 


# 4. WEB приложение

![Web](Assets/Web-interface-2.png)
![Web](Assets/Web-interface-2.png)

Функционал веб приложения доступен только администраторам(хотя возможна реализация какого либо функционала для покупателей и продавцов).

Здесь админы имеют полную информацию о всей БД, могут ее изменять, добавлять, удалять. Но основное их действие будет корректировка социальных цен и категорий, данных продавцов и магазинов, проверка нарушений и проверка исправлений нарушений. Но также можно предусмотреть вариант полной автоматизации этого процесса.
