require "lib.moonloader"
local keys = require "vkeys"
local trstl1 = {['ph'] = 'ф',['Ph'] = 'Ф',['Ch'] = 'Ч',['ch'] = 'ч',['Th'] = 'Т',['th'] = 'т',['Sh'] = 'Ш',['sh'] = 'ш', ['ea'] = 'и',['Ae'] = 'Э',['ae'] = 'э',['size'] = 'сайз',['Jj'] = 'Джейджей',['Whi'] = 'Вай',['whi'] = 'вай',['Ck'] = 'К',['ck'] = 'к',['Kh'] = 'Х',['kh'] = 'х',['hn'] = 'н',['Hen'] = 'Ген',['Zh'] = 'Ж',['zh'] = 'ж',['Yu'] = 'Ю',['yu'] = 'ю',['Yo'] = 'Ё',['yo'] = 'ё',['Cz'] = 'Ц',['cz'] = 'ц', ['ia'] = 'я', ['ea'] = 'и',['Ya'] = 'Я', ['ya'] = 'я', ['ove'] = 'ав',['ay'] = 'эй', ['rise'] = 'райз',['oo'] = 'у', ['Oo'] = 'У', ['Arkady'] = 'Аркадий', ['Alexsander'] = 'Александр', ['Extrasize'] = 'Экстрасайз', ['Ch'] = 'Х',['Alosha'] = 'Алеша', ['ia'] = 'ия', ['Alexander'] = 'Александр',['Brown'] = 'Браун', ['Luxury'] = 'Лакшери', ['Cha'] = 'Ча', ['Ch'] = 'Ч'}
local trstl = {['B'] = 'Б',['Z'] = 'З',['T'] = 'Т',['Y'] = 'Й',['P'] = 'П',['J'] = 'Дж',['X'] = 'Кс',['G'] = 'Г',['V'] = 'В',['H'] = 'Х',['N'] = 'Н',['E'] = 'Е',['I'] = 'И',['D'] = 'Д',['O'] = 'О',['K'] = 'К',['F'] = 'Ф',['y`'] = 'ы',['e`'] = 'э',['A'] = 'А',['C'] = 'К',['L'] = 'Л',['M'] = 'М',['W'] = 'В',['Q'] = 'К',['U'] = 'А',['R'] = 'Р',['S'] = 'С',['zm'] = 'зьм',['h'] = 'х',['q'] = 'к',['y'] = 'и',['a'] = 'а',['w'] = 'в',['b'] = 'б',['v'] = 'в',['g'] = 'г',['d'] = 'д',['e'] = 'е',['z'] = 'з',['i'] = 'и',['j'] = 'ж',['k'] = 'к',['l'] = 'л',['m'] = 'м',['n'] = 'н',['o'] = 'о',['p'] = 'п',['r'] = 'р',['s'] = 'с',['t'] = 'т',['u'] = 'у',['f'] = 'ф',['x'] = 'x',['c'] = 'к',['``'] = 'ъ',['`'] = 'ь',['_'] = ' '}

-- значение для работы скрипта
local mid = ""
local ready_player_1 = 0
local ready_player_2 = 0
local ready_player_3 = 0
local ready_player_4 = 0
local player_name = ""
local player_id = ""
local max_price_ticket = 25000
local min_price_ticket = 100
local max_tickets = 4
local max_tickets_1 = 3
local price = 0
local tickets = 0
local reason1 = ""
local reason2 = ""
local reason3 = ""
local cancellation_licence_last = 0
local reason_takelic = "Не указано"

-- для работы /msm 
local msm = false
local debug = true

-- настройки скрипта (названия)
local script_version = "{99FF33}v1.0"
local script_name = " {ffffff}AHK "..script_version.." {FFFFFF}для М{42aaff}В{f50029}Д"
local short_script_name = "М{42aaff}В{f50029}Д {FFFFFF}»" 
local service = "{42aaff}Debug {FFFFFF}»" 
local notification = "{42aaff}Уведомление {FFFFFF}»" 

-- цветовые значения
local first_color = "{42aaff}"
local second_color = "{ffffff}"
local third_color = "{00e600}"

-- сохранение настроек в cfg
local inicfg = require 'inicfg'
directIni = '../config/mvd_ahk.ini'
messages = inicfg.load(inicfg.load({
    settings = {
		chattc = true,
		deparament = "{f50029}Не указано",
		rchatorg = "{00e600}Включено",
		tag = "{f50029}Не указано",
		chatorg = true,
		rank = "{f50029}Не указано",
		rchattc = "{00e600}Включено",
		chatadm = true,
		rchatadm = "{00e600}Включено",
		name = "{f50029}Не указано",
		rchattrk = "{00e600}Включено",
		rrtag = "{f50029}Выключено",
		chattrk = true,
		rtag = false,
		debug = false,
		debug_adm = "{f50029}Выключено",
    },
}, directIni))
inicfg.save(messages, directIni)

local users = {
    {'Arkady_Kotow', 'kmaukotow', 'admin', 'Кмау', 'Администратор'},
    {'Pelmen', '1488', 'user', 'none', 'player'},
    {'User', 'password', 'user', 'Игрок', 'Пользователь'},
}
-- диалоги

local button_yes = "Выбрать"
local button_no = "Отменить"
local button_confirm = "Выдать"

local name = { }
name.dialog_main_1 = "Взаимодействие с "..player_name.." ["..mid.."]"
name.dialog_main_2 = "Взаимодействие"
name.dialog_hide_chat = "Настройка чатов"
name.dialog_confirm = "Подтверждение"
name.dialog_double_koap = "Добавить что-то еще?"
name.dialog_koap = "Кодекс об административных правонарушениях"
name.dialog_uk = "Уголовный кодекс"
name.dialog_koap_1 = "КоАП » Нарушение скоростного режима"
name.dialog_koap_2 = "КоАП » Езда по встречной полосе"
name.dialog_koap_3 = "КоАП » Проезд красного сигнала светофора"
name.dialog_koap_4 = "КоАП » Парковка в неположенном месте"
name.dialog_koap_5 = "КоАП » Движение в неположенном месте, разговор по телефону во время движения"
name.dialog_koap_6 = "КоАП » Игнорирование сирен спец. служб и инспектора"
name.dialog_koap_7 = "КоАП » Затруднение движения, управление транспортным средством"
name.dialog_koap_8 = "КоАП » Затруднение движения, управление транспортным средством"
name.dialog_koap_9 = "КоАП » Агрессивное вождение"
name.dialog_koap_10 = "КоАП » Регистрационный знак"
name.dialog_koap_11 = "КоАП » Езда в нетрезвом виде"
name.dialog_koap_12 = "КоАП » Ремень безопасности и шлем"
name.dialog_koap_13 = "КоАП » Тонировка"
name.dialog_koap_14 = "КоАП » Отказ предоставления документов"
name.dialog_uk_1 = "УК » Нападение"
name.dialog_uk_2 = "УК » Вооруженное нападение"
name.dialog_uk_3 = "УК » Убийство"
name.dialog_uk_4 = "УК » Угон"
name.dialog_uk_5 = "УК » Взятка"
name.dialog_uk_6 = "УК » Оружие"
name.dialog_uk_7 = "УК » Взятие в заложники"
name.dialog_uk_8 = "УК » Неподчинение"
name.dialog_uk_9 = "УК » Проникновение"
name.dialog_uk_10 = "УК » Наркотические вещества"
name.dialog_uk_11 = "УК » Терроризм"
name.dialog_uk_12 = "УК » Уклонение от уплаты штрафа"
name.dialog_uk_13 = "УК » Хулиганство"
name.dialog_uk_14 = "УК » Разжигание национальной ненависти"
name.dialog_uk_15 = "УК » Митинги"
name.dialog_uk_16 = "УК » Вождение в нетрезвом виде"
name.dialog_uk_17 = "УК » Вымогательство"
name.dialog_uk_18 = "УК » Помеха"
name.dialog_uk_19 = "УК » Помеха"
name.dialog_uk_20 = "УК » Явка с повинной"
name.dialog_uk_21 = "УК » Кража"
name.dialog_uk_22 = "УК » Отказ требования сотрудника"
name.dialog_uk_23 = "УК » Соучастие"
name.dialog_uk_24 = "УК » Государственные преступления"
name.dialog_uk_25 = "УК » Суицид"
name.dialog_uk_26 = "УК » Дезертирство"
name.dialog_takelic = "Лишение водительского удостоверения"
name.dialog_su = "Федеральный розыск"
name.dialog_ticket = "Штраф"
name.dialog_cid = "Выбор цели"
name.dialog_settings = "Изменение настроек"
name.dialog_mstroy = "Меню строя"
name.dialog_mstroy_1 = "Меню проводящего"
name.dialog_mstroy_2 = "Меню слушающего"

local dialog = { }
dialog.main_1 = "МВД » Представиться игроку\nМВД » Проверить документы у игрока\nМВД » Взять документы у игрока"
dialog.main_2 = "МВД » Опознать игрока\nМВД » Надеть на игрока наручники и повести за собой\nМВД » Посадить игрока в полицейский автомобиль\nМВД » Передать игрока в участок\nМВД » Вытащить игрока из транспортного средства\nМВД » Забрать у игрока водительское удостоверние\nМВД » Обыскать игрока\nМВД » Выдать игроку розыск\nМВД » Выдать игроку штраф\nМВД » Начать погоню за игроком\nМВД » Начать следить за игроком"
dialog.main_3 = "МВД » Снять розыск с игрока\nМВД » Снять с игрока наручники и отпустить\nМВД » Отпустить после проверки документов"
dialog.main_4 = "МВД » Приказать прижаться к обочине\nМВД » Начать ломать дверь огорода\nМВД » Проверить светопропускаемость стекол\nМВД » Проверить состояние транспортного средства\nМВД » Достать полицейский планшет\nМВД » Пробить владельца автомобиля\nМВД » Сверить человека с подозреваемым\nМВД » Попросить удостоверение у адвоката\nМВД » Выдать разрешение адвокату\nМВД » Начать эвакуацию Т/C\nМВД » Доставить Т/С на ШС"
--dialog.hide_chat = "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg
dialog.confirm = "Вы уверены, что хотите выдать штраф?"
dialog.confirm_2 = "Вы уверены, что хотите забрать водительское удостоверение?"
dialog.koap = "Глава 1 » Нарушение скоростного режима.\nГлава 2 » Езда по встречной полосе.\nГлава 3 » Проезд красного сигнала светофора.\nГлава 4 » Парковка в неположенном месте.\nГлава 5 » Движение в неположенном месте, разговор по телефону во время движения.\nГлава 6 » Игнорирование сирен спец. служб и инспектора.\nГлава 7 » Затруднение движения, управление транспортным средством.\nГлава 8 » Ненормативная лексика, оскорбление.\nГлава 9 » Агрессивное вождение.\nГлава 10 » Регистрационный знак.\nГлава 11 » Езда в нетрезвом виде.\nГлава 12 » Ремень безопасности и шлем.\nГлава 13 » Тонировка.\nГлава 14 » Отказ предоставления документов.\nМВД » Отменить последнее действие"
dialog.uk = "Глава 1 » Нападение\nГлава 2 » Вооруженное нападение\nГлава 3 » Убийство\nГлава 4 » Угон\nГлава 5 » Взятка\nГлава 6 » Оружие\nГлава 7 » Взятие в заложники\nГлава 8 » Неподчинение\nГлава 9 » Проникновение\nГлава 10 » Наркотические вещества\nГлава 11 » Терроризм\nГлава 12 » Уклонение от уплаты штрафа\nГлава 13 » Хулиганство\nГлава 14 » Разжигание национальной ненависти\nГлава 15 » Митинги\nГлава 16 » Вождение в нетрезвом виде\nГлава 17 » Вымогательство\nГлава 18 » Помеха\nГлава 19 » Явка с повинной\nГлава 20 » Кража\nГлава 21 » Отказ требования сотрудника\nГлава 22 » Соучастие\nГлава 23 » Государственные преступления\nГлава 24 » Суицид\nГлава 25 » Дезертирство\nГлава 26 » До выяснения"
dialog.koap_1 = "1.1. Нарушение скоростного режима.\n1.2 Нарушение скоростного режима, вследствие чего произошло ДТП."
dialog.koap_2 = "2.1. Езда по встречной полосе.\n2.2. Езда по встречной полосе, вследствие чего произошло ДТП."
dialog.koap_3 = "3.1. Проезд красного сигнала светофора.\n3.2. Проезд красного сигнала светофора, вследствие чего произошло ДТП."
dialog.koap_4 = "4.1. Парковка транспортного средства в неположенном месте."
dialog.koap_5 = "5.1. Движение транспортного средства по тротуару, газону, пешеходным дорожкам и прочим местам, неположенным для движения авто.\n5.2. Разговор по телефону во время движения."
dialog.koap_6 = "6.1. Игнорирование сирен спец. служб.\n6.2. За игнорирование сирен спец. служб, вследствие чего произошло ДТП.\n6.3. За игнорирование требований инспектора ДПС."
dialog.koap_7 = "7.1. Затруднение движения транспортным средством.\n7.2. Создание аварийной ситуации на полосе движения.\n7.3. Управление транспортным средством без включенного ближнего света фар.\n7.4. Управление транспортным средством в неисправном состоянии."
dialog.koap_8 = "8.1 Использование ненормативной лексики.\n8.2. Оскорбление граждан.\n8.3. Оскорбление сотрудника при исполнении."
dialog.koap_9 = "9.1. Агрессивное вождение, которое может привести к ДТП."
dialog.koap_10 = "10.1. Передвижение на транспортном средстве без регистрационного знака."
dialog.koap_11 = "11.1. Езда в нетрезвом виде.\n11.2. Езда в нетрезвом виде вследствие чего произошло ДТП."
dialog.koap_12 = "12.1. Езда на транспортном средстве без ремня безопасности.\n12.2. Езда без защитного шлема на мототранспорте."
dialog.koap_13 = "13.1. Езда на транспортном средстве, стекла которого имеют степень светопропускания менее 70%."
dialog.koap_14 = "14.1. Отказ/Нежелание гражданина предоставить сотруднику правоохранительных органов удостоверения личности.\n14.2. Отказ/Нежелание гражданина предоставить сотруднику правоохранительных органов документов на транспорт."
dialog.uk_1 = "1.1. Нападение на гражданское лицо.\n1.2. Нападение на сотрудника правоохранительных органов.\n1.3. Нападение на территорию военной базы.\n1.4. Изнасилование любого гражданина."
dialog.uk_2 = "2.1. Вооружённое нападение на гражданское лицо.\n2.2. Вооружённое нападение на сотрудника правоохранительных органов.\n2.3. Вооружённое нападение на двух и более гражданских лиц."
dialog.uk_3 = "3.1. Убийство гражданского лица.\n3.2. Убийство сотрудника правоохранительных органов."
dialog.uk_4 = "4.1. Попытка угона государственного или частного транспортного средства.\n4.2. Угон государственного или частного транспортного средства."
dialog.uk_5 = "5.1. Дача или попытка дачи взятки должностному лицу.\n5.2. Получение взятки должностным лицом."
dialog.uk_6 = "6.1. Ношение оружия в открытом виде.\n6.2. Использование оружия без лицензии.\n6.3. Нелегальная покупка, перевозка, продажа оружия."
dialog.uk_7 = "7.1. Взятие одного или группы заложников."
dialog.uk_8 = "8.1. Неподчинение сотруднику правоохранительных органов, находящемуся при исполнении.\n8.2. Неподчинение сотруднику правоохранительных органов при обстановке ЧС в Нижегородской области, а так же при проведении спец. операции."
dialog.uk_9 = "9.1. Проникновение на территорию, охраняемую правоохранительными органами.\n9.2. Проникновение на частную территорию без разрешения владельца.\n9.3. Проникновение на территорию закрытой военной базы."
dialog.uk_10 = "10.1. Хранение и/или перевозка наркотических веществ.\n10.2. Сбыт, распространение, приобретение наркотических веществ.\n10.3 Употребление наркотических веществ.\n10.4 Производство/изготовление/выращивание наркотических веществ.\n10.5. Хранение/распространение семян марихуаны."
dialog.uk_11 = "11.1. Планирование/исполнение теракта.\n11.2. Заведомо ложное сообщение о теракте.\n11.3. Специальный подрыв с помощью ТС или лётного транспорта (сброс самолётов/вертолётов)."
dialog.uk_12 = "12.1. Отказ от уплаты штрафа."
dialog.uk_13 = "13.1. Порча имущества гражданских лиц, государственных организаций.\n13.2. Порча/Уничтожение муниципального имущества (столбов, скамеек, остановок)."
dialog.uk_14 = "14.1. Проявление национализма, расизма."
dialog.uk_15 = "15.1. Планирование/Реализация/Соучастие в несанкционированных митингах либо бунтах.\n15.2. Вооруженное насилие, а так же призывы к насилию на митингах.\n15.3. Срыв одобренного мероприятия, помеха проведению одобренного мероприятия."
dialog.uk_16 = "16.1. Управление транспортным средством в состоянии алкогольного и/или наркотического опьянения."
dialog.uk_17 = "17.1. Вымогательство денежных средств, частной собственности.\n17.2. Вымогательство денежных средств, частной собственности должностным лицом."
dialog.uk_18 = "18.1. Помеха сотруднику правоохранительных органов."
dialog.uk_19 = "19.1. Явка с повинной ((с 2-4 уровнем розыска)), преступнику сокращают срок прибывания в тюрьме на 1 год.\n19.2 Явка с повинной ((с 5-6 уровнем розыска)), преступнику сокращают срок прибывания в тюрьме на 2 года."
dialog.uk_20 = "20.1. Кража частного имущества.\n20.2. Кража государственной собственности, собственности организаций, имущества, материалов."
dialog.uk_21 = "21.1. Отказ предъявить паспорт."
dialog.uk_22 = "22.1. Соучастие в преступлении."
dialog.uk_23 = "23.1. Шпионаж/Продажа/Слив государственной информации.\n23.2. Передача информации государственной важности представителям организованных преступных группировок."
dialog.uk_24 = "24.1. Попытка гражданина покончить жизнь самоубийством."
dialog.uk_25 = "25.1. Уклонение от воинской службы."
dialog.uk_26 = "26.1. На время проведения следственно оперативных мероприятий, подозреваемый подается в федеральный розыск, сроком на 6 лет."
dialog.takelic_1 = "Лишение В/У » Указать причину самостоятельно\nЛишение В/У » Использовать причину по последнему штрафу "
dialog.takelic_2 = "Укажите причину лишения В/У"
dialog.su_1 = "Розыск » Указать причину самостоятельно\nРозыск » Выбрать из списка вариантов "
dialog.su_2 = "Укажите уровень розыска"
dialog.su_3 = "Укажите причину объявления в розыск"
dialog.ticket_1 = "Штраф » Указать причину самостоятельно\nШтраф » Выбрать из списка вариантов "
dialog.ticket_2 = "Укажите сумму штрафа"
dialog.ticket_3 = "Укажите причину выдачу штрафа"
dialog.cid = "Введите ID игрока"
dialog.debug = ""
dialog.mstroy = "Меню проводящего\nМеню пришедшего"
dialog.mstroy_1 = "Лекция 1\nЛекция 2\n Лекция 3\n Лекция 4\nТренировка 1\nТренировка 2"





function main() -- база
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	local myID = select(2, sampGetPlayerIdByCharHandle(1))
	local myNick = sampGetPlayerNickname(myID)
	
	sampRegisterChatCommand("mid", cmd_mid)
	sampRegisterChatCommand("msu", cmd_msu)
	sampRegisterChatCommand("mticket", cmd_mticket)
	sampRegisterChatCommand("msm", cmd_msm)
	sampRegisterChatCommand("mtakelic", cmd_takelic)
	sampRegisterChatCommand("msearch", cmd_search)
	sampRegisterChatCommand("mejectout", cmd_ejectout)
	sampRegisterChatCommand("hide_chat", cmd_hidechat)
	sampRegisterChatCommand("msettings", cmd_settings)
	sampRegisterChatCommand("test", cmd_test) --debug
	sampRegisterChatCommand("test2", cmd_test2) --debug
	sampRegisterChatCommand("test3", cmd_test3) --debug
	sampRegisterChatCommand("r", cmd_r) --debug
	sampRegisterChatCommand("crn", test3) --debug
	sampRegisterChatCommand("patrul", patrul) --debug
	sampRegisterChatCommand("mstroy", cmd_mstroy) 
	sampRegisterChatCommand("msetfree", cmd_setfree) --debug
	sampRegisterChatCommand("stroy", cmd_stroy) --debug
	sampRegisterChatCommand("d", cmd_d) --debug
	 sampRegisterChatCommand('debug', function(arg)
        for i = 1, #users do
            if users[i][1] == myNick and users[i][2] == arg then
                sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Рады Вас снова видеть, "..first_color..""..users[i][4].."!", -1)
				sampAddChatMessage(short_script_name.." Вы авторизовались как"..first_color.." "..users[i][5].."", -1)
				sampAddChatMessage(short_script_name.." Теперь Вам доступны "..first_color.."параметры разработчика", -1)
				sampAddChatMessage("", -1)
				messages.settings.debug = true
            end
        end
    end)
	
	sampAddChatMessage("", -1) -- приветственное сообщение
	sampAddChatMessage("Добро пожаловать, "..first_color..""..myNick.."!", -1)
	sampAddChatMessage(script_name..""..second_color.. " запущены!", -1)
	sampAddChatMessage("Успехов на службе!", -1)
	sampAddChatMessage("", -1)
  while true do	
	wait(0)
	
	if messages.settings.debug and debug then 
		dialog.debug = "\n \nРежим авторизованного разработчика\t{00e600}Активирован"
	end
	
	if msm then -- /msm
			sampAddChatMessage(service.." /setmark "..player_id, -1) -- debug
			sampSendChat("/setmark "..player_id)
			wait(1200)
		end
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_1) then -- один из основных диалогов (проверка документов) на ALT + 1
		if mid == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Для начала работы Вам необходимо выбрать игрока.", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function() 
				sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
				while sampIsDialogActive(33) do wait(100) end -- Ожидание закрытия диалога
				local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы выбрали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."для дальнейшей работы.", -1)
							sampAddChatMessage("", -1)
							if messages.settings.name == "{f50029}Не указано" or messages.settings.deparament == "{f50029}Не указано" or messages.settings.rank == "{f50029}Не указано" then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы не настроили скрипт.", -1)
								sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/msettings ", -1)
								sampAddChatMessage("", -1)
							else
								sampShowDialog(2,"Взаимодействие с "..player_name.." ["..mid.."]", dialog.main_1, button_yes, button_no, 2)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Такого игрока нет.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Введите конкретный "..first_color.."ID игрока.", -1)
						sampAddChatMessage("", -1)
					end
			end)	
		else
			sampShowDialog(2,"Взаимодействие с "..player_name.." ["..mid.."]", dialog.main_1, button_yes, button_no, 2)
		end
	end	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_2) then -- один из основных диалогов (принять игрока) на ALT + 2
		if mid == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Для начала работы Вам необходимо выбрать игрока.", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function() 
				sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
				while sampIsDialogActive(33) do wait(100) end -- Ожидание закрытия диалога
				local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы выбрали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."для дальнейшей работы.", -1)
							sampAddChatMessage("", -1)
							if messages.settings.name == "{f50029}Не указано" or messages.settings.deparament == "{f50029}Не указано" or messages.settings.rank == "{f50029}Не указано" then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы не настроили скрипт.", -1)
								sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/msettings ", -1)
								sampAddChatMessage("", -1)
							else
								sampShowDialog(3,"Взаимодействие с "..player_name.." ["..mid.."]", dialog.main_2, button_yes, button_no, 2)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Такого игрока нет.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Введите конкретный "..first_color.."ID игрока.", -1)
						sampAddChatMessage("", -1)
					end
			end)	
		else
			sampShowDialog(3,"Взаимодействие с "..player_name.." ["..mid.."]", dialog.main_2, button_yes, button_no, 2)
		end
	end	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_3) then -- один из основных диалогов (отпустить игрока и тд) на ALT + 3
		if mid == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Для начала работы Вам необходимо выбрать игрока.", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function() 
				sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
				while sampIsDialogActive(33) do wait(100) end -- Ожидание закрытия диалога
				local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы выбрали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."для дальнейшей работы.", -1)
							sampAddChatMessage("", -1)
							if messages.settings.name == "{f50029}Не указано" or messages.settings.deparament == "{f50029}Не указано" or messages.settings.rank == "{f50029}Не указано" then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы не настроили скрипт.", -1)
								sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/msettings ", -1)
								sampAddChatMessage("", -1)
							else
								sampShowDialog(4,"Взаимодействие с "..player_name.." ["..mid.."]", dialog.main_3, button_yes, button_no, 2)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Такого игрока нет.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Введите конкретный "..first_color.."ID игрока.", -1)
						sampAddChatMessage("", -1)
					end
			end)	
		else
			sampShowDialog(4,"Взаимодействие с "..player_name.." ["..mid.."]", dialog.main_3, button_yes, button_no, 2)
		end
	end	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_4) then -- один из основных диалогов (остальное ахк) на ALT + 4
		if messages.settings.name == "{f50029}Не указано" or messages.settings.deparament == "{f50029}Не указано" or messages.settings.rank == "{f50029}Не указано" then
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы не настроили скрипт.", -1)
				sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/msettings ", -1)
				sampAddChatMessage("", -1)
		else
			sampShowDialog(5, name.dialog_main_2, dialog.main_4, button_yes, button_no, 2)
		end
	end	
	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_5) then -- один из основных диалогов (выбор id)
		lua_thread.create(function() 
			sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
			while sampIsDialogActive(33) do wait(100) end -- Ожидание закрытия диалога
			local result, button, _, input = sampHasDialogRespond(33)
			if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
				if sampIsPlayerConnected(input) then
					mid = input
					player_id = mid
					player_name = sampGetPlayerNickname(player_id)
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы выбрали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."для дальнейшей работы.", -1)
					sampAddChatMessage("", -1)
				else
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Такого игрока нет.", -1)
					sampAddChatMessage("", -1)
				end
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Введите конкретный "..first_color.."ID игрока.", -1)
				sampAddChatMessage("", -1)
			end
		end)	
	end		
	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_6) then -- один из основных диалогов (выбор id)
		local get_player_id = getNearestID()
			if get_player_id then
				mid = get_player_id
				player_id = get_player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы выбрали "..first_color.."ближайшего игрока "..second_color.."для дальнейшей работы.", -1)
				sampAddChatMessage(short_script_name.." Им оказался "..first_color..""..player_name.." ["..player_id.."].", -1)
				sampAddChatMessage("", -1)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Рядом никого нет :(", -1)
				sampAddChatMessage("", -1)
			end
	end	
	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_9) then -- /c 60 на ALT + 9
		lua_thread.create(function()
			sampSendChat("/me взглянул на часы")
			wait(777)
			sampSendChat("/c 60")
			wait(777)
			if os.date("%m") == "01" then      -- проверка на месяц и день недели( чтобы писалось текстом )
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." января "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "02" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." февраля "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "03" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." марта "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "04" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." апреля "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "05" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." мая "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "06" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." июня "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "07" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." июля "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "08" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." августа "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "09" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." сентября "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "10" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." октября "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "11" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." ноября "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			elseif os.date("%m") == "12" then
			if os.date("%A") == "Monday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Понедельник » "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Вторник » "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Среда » "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Четверг » "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Пятница » "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Суббота » "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do На часах » "..os.date("%d").." декабря "..os.date("%Y").." » Воскресенье » "..os.date("%X"))
				end
			end
		end)
	end
	
	result, button, list, input = sampHasDialogRespond(2) -- взаимодействие и диалогом ID 2
		if result then
			if button == 1 then
				if list == 0 then
					messages = inicfg.load(nil, directIni)
					lua_thread.create(function()
						sampSendChat("Доброго времени суток!")
						wait(777)
						sampSendChat("Вас беспокоит сотрудник "..messages.settings.deparament.." - "..messages.settings.rank.." "..messages.settings.name..".")
						wait(777)
						sampSendChat("/me отдал честь")
						wait(777)
						sampSendChat("/me достал удостоверение из нагрудного кармана")
						wait(777)
						sampSendChat("/do Удостоверение в руке.")
						wait(777)
						sampSendChat("/me предъявил удостоверение в развернутом виде")
						wait(777)
						sampSendChat("/anim 6 3 ")
						wait(777)
						sampSendChat("/doc "..mid)
					end)
				elseif list == 1 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						sampSendChat("Будьте добры предоставить Ваши документы, а именно паспорт и ПТС.")
						wait(777)
						sampSendChat("А также отстегните ремень безопасности для проверки..")
						wait(777)
						sampSendChat("/n /pass "..myID.." - показать паспорт.")
						wait(777)
						sampSendChat("/n /carpass "..myID.." - показать документы на автомобиль.")
						wait(777)
						sampSendChat("/n /rem - отсегнуть ремень.")
						wait(777)
						sampSendChat("..это обычная проверка, не стоит волноваться.")
					end)
				elseif list == 2 then
					lua_thread.create(function()
						sampSendChat("/me протянул руку и легким движением руки взял у "..player_name.. " документ")
						wait(777)
						sampSendChat("/do Документ в руках.")
						wait(777)
						sampSendChat("/me внимательно изучает данные в документе")
						wait(777)
						sampSendChat("/do Процесс..")
						wait(777)
						sampSendChat("/me вернул документ "..player_name)
					end)
				end
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(3) -- взаимодействие и диалогом ID 3
		if result then
			if button == 1 then
				if list == 0 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы опознали игрока "..first_color..""..player_name.." ["..mid.."]"..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do Фоторобот в рюкзаке.")
						wait(777)
						sampSendChat("/me достал фоторобот из рюкзака.")
						wait(777)
						sampSendChat("/do Фоторобот в руке.")
						wait(777)
						sampSendChat("/me сделал снимок лица, затем отправил его в базу данных")
						wait(777)
						sampSendChat("/do Процесс..")
						wait(777)
						sampSendChat("/do Человек опознан.")
						wait(777)
						sampSendChat("Теперь мы знаем, кто Вы на самом деле..")
						wait(777)
						sampSendChat(rusnick("Ну-с, здравствуй, "..player_name..".."))
					end)
				elseif list == 1 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы скрутили и повели игрока "..first_color..""..player_name.." ["..mid.."]"..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do Наручники висят на поясе.")
						wait(777)
						sampSendChat("/me снял наручники с пояса")
						wait(777)
						sampSendChat("/do Наручники в руке.")
						wait(777)
						sampSendChat("/me легким движением руки схватил руки человека")
						wait(777)
						sampSendChat("/do Руки схачены.")
						wait(777)
						sampSendChat("/todo Надевая наручники на человека*без резких движений! ")
						wait(777)
						sampSendChat("/do Наручники надеты.")
						wait(777)
						sampSendChat("/cuff "..mid)
						wait(777)
						sampSendChat("/me начинает вести задержанного за собой")
						wait(777)
						sampSendChat("/do Процесс..")
						wait(777)
						sampSendChat("/escort "..mid)
						ready_player1 = 1
					end)
				elseif list == 2 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы посадили игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."в патрульный автомобиль.", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/me слегка протянув правую руку вперед, открыл дверь автомобиля")
						wait(777)
						sampSendChat("/do Дверь полицейского автомобиля открыта.")
						wait(777)
						sampSendChat("/me посадил "..player_name.." в автомобиль")
						wait(777)
						sampSendChat("/do "..player_name.." находится в полицейском автомобиле.")
						wait(777)
						sampSendChat("/me легким движением руки закрыл дверь автомобиля")
						wait(777)
						sampSendChat("/do  Дверь полицейского автомобиля закрыта.")
						wait(777)
						sampSendChat("/putpl "..mid)
					end)
				elseif list == 3 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы арестовали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/me открыл двери полицейского участка")
						wait(777)
						sampSendChat("/do Двери открыты.")
						wait(777)
						sampSendChat("/me проводел "..player_name.." в камеру")
						wait(777)
						sampSendChat("/do "..player_name.." под заключением.")
						wait(777)
						sampSendChat("/me легким движением руки закрыл дверь участка")
						wait(777)
						sampSendChat("/do  Дверь полицейского участка закрыта.")
						wait(777)
						sampSendChat("/arrest "..mid)
					end)
				elseif list == 4 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы вытащили игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."из автомобиля.", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do Стекло автомобиля целое.")
						wait(777)
						sampSendChat("/ejectout "..mid)
						wait(777)
						sampSendChat("/todo Точным ударом разбивая стекло*Раз не захотели сами выходить, поможем!")
						wait(777)
						sampSendChat("/do Стекло разбито.")
						wait(777)
						sampSendChat("/me открыл дверь через салон и вытащил человека из автомобиля")
						wait(777)
						sampSendChat("/do Человек стоит на улице.")
					end)
				elseif list == 5 then
				lua_thread.create(function()
					sampShowDialog(28, name.dialog_takelic, dialog.takelic_1, button_yes, button_no, 2)
					sampSendChat("/me достал КПК из сумки")
					wait(777)
					sampSendChat("/me открыл базу нарушений")
					wait(777)
					sampSendChat("/me заполняет информацию о нарушении и нарушителе")
					wait(777)
					sampSendChat("/do Данные актуализированы.")
					wait(777)
					sampSendChat("/me забрал водительское удостоверение")
					wait(777)
					sampSendChat("/do Водительское удостоверение забрано.")
					wait(777)
				end)
				elseif list == 6 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы обыскиваете игрока "..first_color..""..player_name.." ["..mid.."] "..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do Нашивка сотрудника МВД на груди.")
						wait(777)
						sampSendChat("/me достал ордер на обыск и показал его человеку напротив")
						wait(777)
						sampSendChat("Повернитесь спиной, подняв руки. Без резких движений!")
						wait(777)
						sampSendChat("/me надел перчатки на руки")
						wait(777)
						sampSendChat("/me открыл дверь через салон и вытащил человека из автомобиля")
						wait(777)
						sampSendChat("/me проводит руками по верхней части тела")
						wait(777)
						sampSendChat("/me проводит руками по туловищу")
						wait(777)
						sampSendChat("/anim 5 1")
						wait(777)
						sampSendChat("/me проводит руками по нижней части тела")
						wait(777)
						sampSendChat("/do Обыск завершен.")
						wait(777)
						sampSendChat("Подведем итоги обыска..")
						wait(777)
						sampSendChat("/search "..mid)
					end)
				elseif list == 7 then
					sampShowDialog(31, name.dialog_su, dialog.su_1, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me достал КПК из сумки")
						wait(777)
						sampSendChat("/me сохранил фоторобот подозреваемого, перемещая его в базу")
						wait(777)
						sampSendChat("/do Подозреваемый опознан.")
						wait(777)
						sampSendChat("/me объявляет подозреваемого в федеральный розыск")
					end)
				elseif list == 8 then
					tickets = 0
					reason1 = ""
					reason2 = ""
					reason3 = ""
					price = 0
					sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me достал КПК из сумки")
						wait(777)
						sampSendChat("/me открыл базу штрафных квитанций")
						wait(777)
						sampSendChat("/me заполняет штрафную квитанцию")
						wait(777)
						sampSendChat("/todo Отправляя штрафную квитанцию*выслал реквизиты для оплаты Вам на эл. почту")
						wait(777)
						sampSendChat("Вам необходимо оплатить штраф в течении трех дней, иначе наши сотрудники ...")
						wait(777)
						sampSendChat(" ...аннулируют Ваше водительское удостоверение. Всего доброго, не нарушайте!")
					end)
				elseif list == 9 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы начали погоню за игроком "..first_color..""..player_name.." ["..mid.."].", -1)
					sampAddChatMessage("", -1)
					sampSendChat("/pg "..mid, -1)
					sampAddChatMessage(service.." /pg "..mid, -1) -- Debug
					lua_thread.create(function()
						sampSendChat("/me достал рацию из рюкзака")
						wait(777)
						sampSendChat("/do Рация в руке.")
						wait(777)
						sampSendChat("/me доложил диспечеру, что начал погоню за нарущителем")
					end)
				elseif list == 10 then	
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы начали преследовать игрока "..first_color..""..player_name.." ["..mid.."].", -1)
					sampAddChatMessage(short_script_name.." Чтобы закончить преследование, используйте "..first_color.."/msm", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/me взял в руки планшет")
						wait(777)
						sampSendChat("/me включил программу 'Федеральный розыск'")
						wait(777)
						sampSendChat("/do Загрузка.. ")
						wait(777)
						sampSendChat("/me получил данные из списка подозреваемых")
						wait(777)
						sampSendChat("/do Данные получены.")
						wait(1000)
						msm = not msm
					end)
				end
			end
		end		
		
		result, button, list, input = sampHasDialogRespond(4) -- взаимодействие и диалогом ID 4
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function()
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Вы очистили розыск игроку "..first_color..""..player_name.." ["..mid.."].", -1)
						sampAddChatMessage("", -1)
						sampSendChat("/do "..player_name.." находится в федеральном розыске.")
						wait(777)
						sampSendChat("/me достал КПК из рюкзака и включил его")
						wait(777)
						sampSendChat("/do КПК готов к работе.")
						wait(777)
						sampSendChat("/me зашел в базу данных МВД и нашел нужного человека")
						wait(777)
						sampSendChat("/me удалил пометку 'Федеральный розыск' с личного дела")
						wait(777)
						sampSendChat("/do "..player_name.." не находится в федеральном розыске.")
						wait(777)
						sampSendChat("/clear "..mid)
					end)
				elseif list == 1 then
					lua_thread.create(function()
						sampSendChat("/me достал ключи от наручников и вставил их в резьбу")
						wait(777)
						sampSendChat("/do Наручники открыты.")
						wait(777)
						sampSendChat("/me снял их с подозреваемого и отпустил")
						wait(777)
						sampSendChat("/do Человек свободен.")
						wait(777)
						sampSendChat("/uncuff "..mid)
						wait(777)
						sampSendChat("/escort "..mid)
					end)
				elseif list == 2 then
					lua_thread.create(function()
						sampSendChat("/me вернул документы гражданину '"..rusnick(player_name).."'")
						wait(777)
						sampSendChat("Держите, у Вас все хорошо.")
						wait(777)
						sampSendChat("Спасибо за предоставление документов, можете быть свободны.")
					end)
				end
			end
		end	
		
		result, button, list, input = sampHasDialogRespond(5) -- взаимодействие и диалогом ID 5
		if result then
			if button == 1 then
				if list == 0 then
					if isCharInAnyCar(PLAYER_PED) then
					lua_thread.create(function()
						sampSendChat("/me взял мегафон в руки, затем нажал кнопку 'М'")
						wait(777)
						sampSendChat("/m Говорит сотрудник "..messages.settings.deparament.." - "..messages.settings.rank.." "..messages.settings.name..".")
						wait(777)
						sampSendChat("/m Водитель Т/С , останавливаемся и прижимаемся к обочине!")
						wait(777)
						sampSendChat("/m В случае неподчинения я буду вынужден открыть огонь на поражение!")
						wait(777)
						sampSendChat("/me отпустил кнопку 'М', затем убрал мегафон")
					end)
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Вы не находитесь в  "..first_color.."полицейском авто!", -1)
						sampAddChatMessage("", -1)
					end
				elseif list == 1 then
					sampAddChatMessage(2)
				elseif list == 4 then
					lua_thread.create(function()
						sampSendChat("/do Полицейский планшет находится в рюкзаке.")
						wait(777)
						sampSendChat("/me легким движением руки достал планшет из рюкзака и включил его")
						wait(777)
						sampSendChat("/todo Пока планшет загружает списки*ну-с, что же тут интересного..")
						wait(777)
						sampSendChat("/do Списки МВД загружены.")
						wait(777)
						sampSendChat("/police_tablet")
						wait(777)
						sampSendChat("/do Полицейский планшет готов к работе.")
					end)
				elseif list == 5 then
					lua_thread.create(function()
						sampSendChat("/do Полицейский планшет находится в рюкзаке.")
						wait(777)
						sampSendChat("/me легким движением руки достал планшет из рюкзака и включил его")
						wait(777)
						sampSendChat("/todo Пока планшет загружает списки автомобилей*давай же скорее..")
						wait(777)
						sampSendChat("/do Списки транспортных средств загружены.")
						wait(777)
						sampSendChat("/me открыл инструмент 'Поиск по информации'")
						wait(777)
						sampSendChat("/do Программа открыта.")
						wait(777)
						sampSendChat("/me быстро вводит известные данные об автомобиле")
						wait(777)
						sampSendChat("/do Выполняется поиск.")
						wait(777)
						sampSendChat("/do Процесс..")
						wait(777)
						sampSendChat("/do Информация найдена..")
						wait(777)
						sampSendChat("/me изучает найденную информацию")
						wait(777)
						sampSendChat("/do Личность автовладельца известна.")
					end)
				elseif list == 7 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						if os.date("%H") == "01" or os.date("%H") == "02" or os.date("%H") == "03" or os.date("%H") == "04" or os.date("%H") == "05" or os.date("%H") == "06" then 
							sampSendChat("Доброй ночи, т. Адвокат.")
						elseif os.date("%H") == "07" or os.date("%H") == "08" or os.date("%H") == "09" or os.date("%H") == "10" or os.date("%H") == "11" or os.date("%H") == "12" then 
							sampSendChat("Доброе утро, т. Адвокат.")
						elseif os.date("%H") == "13" or os.date("%H") == "14" or os.date("%H") == "15" or os.date("%H") == "16" or os.date("%H") == "17" or os.date("%H") == "18" then 
							sampSendChat("Добрый день, т. Адвокат.")
						elseif os.date("%H") == "19" or os.date("%H") == "20" or os.date("%H") == "21" or os.date("%H") == "22" or os.date("%H") == "23" or os.date("%H") == "24" then 
							sampSendChat("Добрый вечер, т. Адвокат.")
						end
						wait(777)
						sampSendChat("Я "..messages.settings.rank.." - "..messages.settings.name)
						wait(777)
						sampSendChat("Разрешите увидеть Ваше удостоверение?")
						wait(777)
						sampSendChat("/n /doc "..myID)
					end)
				elseif list == 8 then
				lua_thread.create(function() 
					sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
					while sampIsDialogActive(33) do wait(100) end -- Ожидание закрытия диалога
					local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы выбрали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color..", как адвоката.", -1)
							sampAddChatMessage("", -1)
							sampSendChat("/me взял удостоверение адвоката")
							wait(777)
							sampSendChat("/do Удостоверение в руке.")
							wait(777)
							sampSendChat("/me ознакомился с удостоверением")
							wait(777)
							sampSendChat("/do Гражданин "..rusnick(player_name).." -  Должность: Адвокат")
							wait(777)
							sampSendChat("/me вернул документ адвокату")
							wait(777)
							sampSendChat("Спасибо, держите, все хорошо..")
							wait(777)
							sampSendChat("/me достал бланк и ручку")
							wait(777)
							sampSendChat("/do Бланк и ручка в руке.")
							wait(777)
							sampSendChat("/me начал заполнять данные о заключенном")
							wait(777)
							sampSendChat("/do Данные заполнены.")
							wait(777)
							sampSendChat("/todo Отрывая листок*проверьте, все ли верно?")
							wait(777)
							sampSendChat("/me передал бланк на освобождение заключенного")
							wait(777)
							sampSendChat("/do Бланк передан..")
							wait(777)
							sampSendChat("/setfree "..mid)
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Такого игрока нет.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Введите конкретный "..first_color.."ID игрока.", -1)
						sampAddChatMessage("", -1)
					end
				end)
				elseif list == 9 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						sampSendChat("/me достал планшет из рюказака и включил его")
						wait(777)
						sampSendChat("/do Планшет МВД включен.")
						wait(777)
						sampSendChat("/me зашел в раздел 'Эвакуация Т/С'")
						wait(777)
						sampSendChat("/me начал кнопку 'Фотография' и зафиксировал нарушение")
						wait(777)
						sampSendChat("/do Фиксация сохранена в базе МВД.")
						wait(777)
						sampSendChat("/me убрал планшет в рюкзак")
						wait(777)
						sampSendChat("/do Эвакуатор стоит неподвижно.")
						wait(777)
						sampSendChat("/me медленно опустил кран эвакуатора")
						wait(777)
						sampSendChat("/do Кран опущен.")
						wait(777)
						sampSendChat("/me аккуратно зацепил Т/С на кран")
						wait(777)
						sampSendChat("/attach")
						wait(777)
						sampSendChat("/do Транспортное средство зацеплено.")
						wait(777)
						sampSendChat("/me поднял кран эвакуатора")
						wait(1000)
						sampSendChat("/do Кран поднят.")
						wait(1000)
						sampSendChat("/me начал эвакуацию Т/С")
						wait(1000)
						sampSendChat("/me доложил диспечеру о начале эвакуации")
						wait(1000)
						sampSendChat("/r "..messages.settings.tag.." Докладывает "..messages.settings.rank.." "..messages.settings.name.." | Начинаю эвакуацию транспортного средства на ШС")
						wait(1000)
						sampSendChat("/c 60")
						wait(1000)
					end)
				elseif list == 10 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						sampSendChat("/do На панеле эвакуатора джойстик.")
						wait(777)
						sampSendChat("/me взял правой рукой джойстик")
						wait(777)
						sampSendChat("/me отцепил крюк от бампера транспортного средства")
						wait(777)
						sampSendChat("/do Крюс эвакуатора отцеплена от транспортного средства.")
						wait(777)
						sampSendChat("/me доложил диспечеру о конце эвакуации")
						wait(777)
						sampSendChat("/r "..messages.settings.tag.." Докладывает "..messages.settings.rank.." "..messages.settings.name.." | Эвакуировал транспортное средство на ШС")
						wait(777)
						sampSendChat("/c 60")
					end)
				end
			end
		end		
		
	result, button, list, input = sampHasDialogRespond(6) -- взаимодействие и диалогом ID 6
		if result then
			if button == 1 then
				if list == 0 then
					if messages.settings.chattc == true then
							messages.settings.chattc = false
							messages.settings.rchattc = "{f50029}Выключено"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы скрыли "..first_color.."рацию дальнобойщиков!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						elseif messages.settings.chattc == false then
							messages.settings.chattc = true
							messages.settings.rchattc = "{00e600}Включено"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы снова видите "..first_color.."рацию дальнобойщиков!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						end
				elseif list == 1 then
					if messages.settings.chattrk == true then
							messages.settings.chattrk = false
							messages.settings.rchattrk = "{f50029}Выключено"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы скрыли "..first_color.."уведомления от ТРК!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						elseif messages.settings.chattrk == false then
							messages.settings.chattrk = true
							messages.settings.rchattrk = "{00e600}Включено"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы снова видите "..first_color.."уведомления от ТРК!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						end
				elseif list == 2 then
					if messages.settings.chatadm == true then
						messages.settings.chatadm = false
						messages.settings.rchatadm = "{f50029}Выключено"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы скрыли "..first_color.."наказания от администрации!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					elseif messages.settings.chatadm == false then
						messages.settings.chatadm = true
						messages.settings.rchatadm = "{00e600}Включено"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы снова видите "..first_color.."наказания от администрации!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					end
				elseif list == 3 then
					if messages.settings.chatorg == true then
						messages.settings.chatorg = false
						messages.settings.rchatorg = "{f50029}Выключено"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы скрыли "..first_color.."рацию организации!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					elseif messages.settings.chatorg == false then
						messages.settings.chatorg = true
						messages.settings.rchatorg = "{00e600}Включено"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы снова видите "..first_color.."рацию организации!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					end
				end
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(7)
		
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(40, name.dialog_uk_1, dialog.uk_1, button_yes, button_no, 2)
				elseif list == 1 then
					sampShowDialog(41, name.dialog_uk_2, dialog.uk_2, button_yes, button_no, 2)
				elseif list == 2 then
					sampShowDialog(42, name.dialog_uk_3, dialog.uk_3, button_yes, button_no, 2)
				elseif list == 3 then
					sampShowDialog(43, name.dialog_uk_4, dialog.uk_4, button_yes, button_no, 2)
				elseif list == 4 then
					sampShowDialog(44, name.dialog_uk_5, dialog.uk_5, button_yes, button_no, 2)
				elseif list == 5 then
					sampShowDialog(45, name.dialog_uk_6, dialog.uk_6, button_yes, button_no, 2)
				elseif list == 6 then
					sampShowDialog(46, name.dialog_uk_7, dialog.uk_7, button_yes, button_no, 2)
				elseif list == 7 then
					sampShowDialog(47, name.dialog_uk_8, dialog.uk_8, button_yes, button_no, 2)
				elseif list == 8 then
					sampShowDialog(48, name.dialog_uk_9, dialog.uk_9, button_yes, button_no, 2)
				elseif list == 9 then
					sampShowDialog(49, name.dialog_uk_10, dialog.uk_10, button_yes, button_no, 2)
				elseif list == 10 then
					sampShowDialog(50, name.dialog_uk_11, dialog.uk_11, button_yes, button_no, 2)
				elseif list == 11 then
					sampShowDialog(51, name.dialog_uk_12, dialog.uk_12, button_yes, button_no, 2)
				elseif list == 12 then
					sampShowDialog(52, name.dialog_uk_13, dialog.uk_13, button_yes, button_no, 2)
				elseif list == 13 then
					sampShowDialog(53, name.dialog_uk_14, dialog.uk_14, button_yes, button_no, 2)
				elseif list == 14 then
					sampShowDialog(54, name.dialog_uk_15, dialog.uk_15, button_yes, button_no, 2)
				elseif list == 15 then
					sampShowDialog(55, name.dialog_uk_16, dialog.uk_16, button_yes, button_no, 2)
				elseif list == 16 then
					sampShowDialog(56, name.dialog_uk_17, dialog.uk_17, button_yes, button_no, 2)
				elseif list == 17 then
					sampShowDialog(57, name.dialog_uk_18, dialog.uk_18, button_yes, button_no, 2)
				elseif list == 18 then
					sampShowDialog(58, name.dialog_uk_19, dialog.uk_19, button_yes, button_no, 2)
				elseif list == 19 then
					sampShowDialog(59, name.dialog_uk_20, dialog.uk_20, button_yes, button_no, 2)
				elseif list == 20 then
					sampShowDialog(60, name.dialog_uk_21, dialog.uk_21, button_yes, button_no, 2)
				elseif list == 21 then
					sampShowDialog(61, name.dialog_uk_22, dialog.uk_22, button_yes, button_no, 2)
				elseif list == 22 then
					sampShowDialog(62, name.dialog_uk_23, dialog.uk_23, button_yes, button_no, 2)
				elseif list == 23 then
					sampShowDialog(63, name.dialog_uk_24, dialog.uk_24, button_yes, button_no, 2)
				elseif list == 24 then
					sampShowDialog(64, name.dialog_uk_25, dialog.uk_25, button_yes, button_no, 2)
				elseif list == 25 then
					sampShowDialog(65, name.dialog_uk_26, dialog.uk_26, button_yes, button_no, 2)
				
				end
			end
		end	
		
		
	result, button, list, input = sampHasDialogRespond(10)
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(11, name.dialog_koap_1, dialog.koap_1, button_yes, button_no, 2)
				elseif list == 1 then
					sampShowDialog(12, name.dialog_koap_2, dialog.koap_2, button_confirm, button_no, 2)
				elseif list == 2 then
					sampShowDialog(13, name.dialog_koap_3, dialog.koap_3, button_confirm, button_no, 2)
				elseif list == 3 then
					sampShowDialog(14, name.dialog_koap_4, dialog.koap_4, button_confirm, button_no, 2)
				elseif list == 4 then
					sampShowDialog(15, name.dialog_koap_5, dialog.koap_5, button_confirm, button_no, 2)
				elseif list == 5 then
					sampShowDialog(16, name.dialog_koap_6, dialog.koap_6, button_confirm, button_no, 2)
				elseif list == 6 then
					sampShowDialog(17, name.dialog_koap_7, dialog.koap_7, button_confirm, button_no, 2)
				elseif list == 7 then
					sampShowDialog(18, name.dialog_koap_8, dialog.koap_8, button_confirm, button_no, 2)
				elseif list == 8 then
					sampShowDialog(19, name.dialog_koap_9, dialog.koap_9, button_confirm, button_no, 2)
				elseif list == 9 then
					sampShowDialog(20, name.dialog_koap_10, dialog.koap_10, button_confirm, button_no, 2)
				elseif list == 10 then
					sampShowDialog(21, name.dialog_koap_11, dialog.koap_11, button_confirm, button_no, 2)
				elseif list == 11 then
					sampShowDialog(22, name.dialog_koap_12, dialog.koap_12, button_confirm, button_no, 2)
				elseif list == 12 then
					sampShowDialog(23, name.dialog_koap_13, dialog.koap_13, button_confirm, button_no, 2)
				elseif list == 13 then
					sampShowDialog(24, name.dialog_koap_14, dialog.koap_14, button_confirm, button_no, 2)
				elseif list == 14 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вам нечего отменять.", -1)
					sampAddChatMessage("", -1)
				end
			end
		end			
		
	result, button, list, input = sampHasDialogRespond(11)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "1.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				elseif list == 1 then
					t_amount = 10000
					reason = "1.2 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(12)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "2.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				elseif list == 1 then
					t_amount = 10000
					reason = "2.2 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(13)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 3000
					reason = "3.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 10000
					reason = "3.2 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(14)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "4.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(15)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "5.1 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 1000
					reason = "5.2 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(16)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 4000
					reason = "6.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 10000
					reason = "6.2 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 2 then
					t_amount = 15000
					reason = "6.3 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(17)

		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 3000
					reason = "7.1 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 4000
					reason = "7.2 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 2 then
					t_amount = 3000
					reason = "7.3 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 3 then
					t_amount = 3000
					reason = "7.4 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(18)
	
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 1000
					reason = "8.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 3000
					reason = "8.2 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 2 then
					t_amount = 15000
					reason = "8.3 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	

	result, button, list, input = sampHasDialogRespond(19)
	
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 10000
					reason = "9.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(20)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "10.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(21)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "11.1 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 25000
					reason = "11.2 КоАП"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(22)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "12.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 5000
					reason = "12.2 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(23)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 1000
					reason = "13.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(24)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 15000
					reason = "14.1 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 15000
					reason = "14.2 КоАП"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color..""..max_price_ticket.." руб..", -1)
						sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
						sampAddChatMessage("", -1)
						tickets = tickets - 1
						price = price - t_amount
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
					else
						sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						if tickets == 1 then
							reason1 = reason
						elseif tickets == 2 then
							reason2 = reason
						elseif tickets == 3 then
							reason3 = reason
						end
						if tickets == max_tickets then
							sampAddChatMessage(" ", -1)
							sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
							sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." Вы добавили к штрафу игрока "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." руб. ", -1)
								sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." За данное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
								sampAddChatMessage(" ", -1)
								reason_takelic = reason
								cancellation_licence_last = 1
							end
						end
					end
			else
				sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
			end
		end	
	
			
	result, button, list, input = sampHasDialogRespond(25)
	
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(11, name.dialog_koap_1, dialog.koap_1, button_confirm, button_no, 2) 
				elseif list == 1 then
					sampShowDialog(12, name.dialog_koap_2, dialog.koap_2, button_confirm, button_no, 2)
				elseif list == 2 then
					sampShowDialog(13, name.dialog_koap_3, dialog.koap_3, button_confirm, button_no, 2)
				elseif list == 3 then
					sampShowDialog(14, name.dialog_koap_4, dialog.koap_4, button_confirm, button_no, 2)
				elseif list == 4 then
					sampShowDialog(15, name.dialog_koap_5, dialog.koap_5, button_confirm, button_no, 2)
				elseif list == 5 then
					sampShowDialog(16, name.dialog_koap_6, dialog.koap_6, button_confirm, button_no, 2)
				elseif list == 6 then
					sampShowDialog(17, name.dialog_koap_7, dialog.koap_7, button_confirm, button_no, 2)
				elseif list == 7 then
					sampShowDialog(18, name.dialog_koap_8, dialog.koap_8, button_confirm, button_no, 2)
				elseif list == 8 then
					sampShowDialog(19, name.dialog_koap_9, dialog.koap_9, button_confirm, button_no, 2)
				elseif list == 9 then
					sampShowDialog(20, name.dialog_koap_10, dialog.koap_10, button_confirm, button_no, 2)
				elseif list == 10 then
					sampShowDialog(21, name.dialog_koap_11, dialog.koap_11, button_confirm, button_no, 2)
				elseif list == 11 then
					sampShowDialog(22, name.dialog_koap_12, dialog.koap_12, button_confirm, button_no, 2)
				elseif list == 12 then
					sampShowDialog(23, name.dialog_koap_13, dialog.koap_13, button_confirm, button_no, 2)
				elseif list == 13 then
					sampShowDialog(24, name.dialog_koap_14, dialog.koap_14, button_confirm, button_no, 2)
				elseif list == 14 then
					tickets = tickets - 1
					price = price - t_amount
					if cancellation_licence_last == 1 then
						cancellation_licence = 0
						cancellation_licence_last = 0
					end
					sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Последнее действие было отменено.", -1)
					sampAddChatMessage(short_script_name.." Итоговая сумма: "..third_color..""..price.." руб. "..second_color.."Отмененный штраф:"..first_color.." "..reason, -1)
					sampAddChatMessage("", -1)
				end
			else
				if price > max_price_ticket then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Максимальная сумма штрафа "..third_color""..max_price_ticket.." руб.", -1)
					sampAddChatMessage("", -1)
				else
					if tickets == max_tickets then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." За один раз максимально можно выдать штраф только с "..first_color..""..max_tickets_1..""..second_color.." причинами. ", -1)
						sampAddChatMessage("", -1)
					else 
						sampShowDialog(26, name.dialog_confirm, dialog.confirm, button_confirm, button_no, 0)
					end
				end
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(26)
		
		if result then
			if button == 1 then
				if tickets == 1 then
					sampAddChatMessage(service.. " /ticket "..player_id.." "..price.." "..reason, -1) 
					sampSendChat("/ticket "..player_id.." "..price.." "..reason, -1) 
					wait(1800)
					if cancellation_licence == 1 then
						sampAddChatMessage(" ", -1)
						sampAddChatMessage(notification.." За выданное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
						sampAddChatMessage(" ", -1)
						sampShowDialog(29, name.dialog_confirm, dialog.confirm_2, button_confirm, button_no, 0)
					end
				elseif tickets == 2 then
					sampAddChatMessage(service.. " /ticket "..player_id.." "..price.." "..reason1.." + "..reason2, -1) 
					sampSendChat("/ticket "..player_id.." "..price.." "..reason1.." + "..reason2, -1) 
					wait(1800)
					if cancellation_licence == 1 then
						sampAddChatMessage(" ", -1)
						sampAddChatMessage(notification.." За выданное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
						sampAddChatMessage(" ", -1)
						sampShowDialog(29, name.dialog_confirm, dialog.confirm_2, button_confirm, button_no, 0)
					end
				elseif tickets == 3 then
					sampAddChatMessage(service.. " /ticket "..player_id.." "..price.." "..reason1.." + "..reason2.. " + "..reason3, -1) 
					sampSendChat("/ticket "..player_id.." "..price.." "..reason1.." + "..reason2.. " + "..reason3, -1) 
					wait(1800)
					if cancellation_licence == 1 then
						sampAddChatMessage(" ", -1)
						sampAddChatMessage(notification.." За выданное нарушение предусмотрено "..first_color.."лишение водительского удостоверения!", -1)
						sampAddChatMessage(" ", -1)
						sampShowDialog(29, name.dialog_confirm, dialog.confirm_2, button_confirm, button_no, 0)
					end
				end
			end
		end	
		
		
		
	result, button, list, input = sampHasDialogRespond(28) -- взаимодействие и диалогом ID 28
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function() 
						sampShowDialog(27, name.dialog_takelic, dialog.takelic_2, button_yes, button_no, 1)
						while sampIsDialogActive(27) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(27)
					if input:find("^%A+$") then
							reason_takelic = input
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы лишили игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.." водительского удостоверения. Причина: "..first_color..""..input..".", -1)
							sampAddChatMessage("", -1)
							sampSendChat("/takelic "..mid.." "..input, -1)
							sampAddChatMessage(service.." /takelic "..mid.." "..input, -1) -- Debug
						else
							sampShowDialog(28, name.dialog_takelic, dialog.takelic_1, button_yes, button_no, 2)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите конкретную причину "..first_color.."лишения В/У. "..second_color.."Например: "..first_color.."3.1 КоАП", -1)
							sampAddChatMessage("", -1)
						end
						end)
				elseif list == 1 then
					if reason_takelic == "Не указано" then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Причина не была указана.", -1)
						sampAddChatMessage("", -1)
						sampShowDialog(28, name.dialog_takelic, dialog.takelic_1, button_yes, button_no, 2)
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." Вы лишили игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.." водительского удостоверения. Причина: "..first_color..""..reason_takelic..".", -1)
						sampAddChatMessage("", -1)
						sampSendChat("/takelic "..mid.." "..reason_takelic, -1)
						sampAddChatMessage(service.." /takelic "..mid.." "..reason_takelic, -1) -- Debug
						lua_thread.create(function()
							sampSendChat("/me достал КПК из сумки")
							wait(777)
							sampSendChat("/me открыл базу нарушений")
							wait(777)
							sampSendChat("/me заполняет информацию о нарушении и нарушителе")
							wait(777)
							sampSendChat("/do Данные актуализированы.")
							wait(777)
							sampSendChat("/me забрал водительское удостоверение")
							wait(777)
							sampSendChat("/do Водительское удостоверение забрано.")
						end)
					end	
				end
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(31) -- взаимодействие и диалогом ID 31
		if result then
			if button == 1 then
				if list == 0 then
						sampShowDialog(30, name.dialog_su, dialog.su_2, button_yes, button_no, 1)
						while sampIsDialogActive(30) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(30)
						if input:find("^%d+$") then
							if input == "1" or input == "2" or input == "3" or input == "4" or input == "5" or input == "6" then
								level = input
								sampShowDialog(32, name.dialog_su, dialog.su_3, button_yes, button_no, 1)
								while sampIsDialogActive(32) do wait(100) end -- Ожидание закрытия диалога
								local result, button, _, input = sampHasDialogRespond(32)
								reason = input
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы объявили игрока "..first_color..""..player_name.." ["..mid.."]"..second_color.." в федеральный розыск.", -1)
								sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.." "..level..". "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage("", -1)
								sampSendChat("/su "..mid.." "..level.." "..reason, -1)
								sampAddChatMessage(service.." /su "..mid.." "..level.." "..reason, -1) -- Debug
							else
								sampShowDialog(31, name.dialog_su, dialog.su_1, button_yes, button_no, 2)
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Введите конкретный уровень розыска "..first_color.."(от 1 до 6)", -1)
								sampAddChatMessage("", -1)
							end
						else
							sampShowDialog(31, name.dialog_su, dialog.su_1, button_yes, button_no, 2)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите конкретный уровень розыска "..first_color.."(от 1 до 6)", -1)
							sampAddChatMessage("", -1)
						end
				elseif list == 1 then
					sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
				end
			end
		end		
		
	result, button, list, input = sampHasDialogRespond(35) -- взаимодействие и диалогом ID 31
		if result then
			if button == 1 then
				if list == 0 then
						sampShowDialog(39, name.dialog_ticket, dialog.ticket_2, button_yes, button_no, 1)
						while sampIsDialogActive(39) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(39)
						if input:find("^%d+$") then
							if input > max_price_ticket or input < min_price_ticket then
								amount = input
								sampShowDialog(38, name.dialog_ticket, dialog.ticket_3, button_yes, button_no, 1)
								while sampIsDialogActive(38) do wait(100) end -- Ожидание закрытия диалога
								local result, button, _, input = sampHasDialogRespond(38)
								reason = input
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы выдали игроку "..first_color..""..player_name.." ["..mid.."]"..second_color.." штраф.", -1)
								sampAddChatMessage(short_script_name.." Сумма:"..first_color.." "..amount..". "..second_color.."Причина:"..first_color.." "..reason, -1)
								sampAddChatMessage("", -1)
								sampSendChat("/ticket "..mid.." "..amount.." "..reason, -1)
								sampAddChatMessage(service.." /ticket "..mid.." "..amount.." "..reason, -1) -- Debug
							else
								sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Введите конкретную сумму штрафа ( от "..third_color..""..min_price_ticket.." руб. "..second_color.."до "..third_color..""..max_price_ticket.." руб."..second_color.." )", -1)
								sampAddChatMessage("", -1)
							end
						else
							sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите конкретную сумму штрафа ( от "..third_color..""..min_price_ticket.." руб. "..second_color.."до "..third_color..""..max_price_ticket.." руб."..second_color.." )", -1)
							sampAddChatMessage("", -1)
						end
				elseif list == 1 then
					sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
				end
			end
		end	

	result, button, list, input = sampHasDialogRespond(29)
		
		if result then
			if button == 1 then
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы лишили игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.." водительского удостоверения. Причина: "..first_color..""..reason_takelic..".", -1)
				sampAddChatMessage("", -1)
				sampSendChat("/takelic "..mid.." "..reason_takelic, -1)
				sampAddChatMessage(service.." /takelic "..mid.." "..reason_takelic, -1) -- Debug
				lua_thread.create(function()
					sampSendChat("/me достал КПК из сумки")
					wait(777)
					sampSendChat("/me открыл базу нарушений")
					wait(777)
					sampSendChat("/me заполняет информацию о нарушении и нарушителе")
					wait(777)
					sampSendChat("/do Данные актуализированы.")
					wait(777)
					sampSendChat("/me забрал водительское удостоверение")
					wait(777)
					sampSendChat("/do Водительское удостоверение забрано.")
				end)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(36)
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "Введите значение 'Имя Фамилия'\nПримечание: необходимо вводить русскими буквами\nНапример: Аркадий Котов", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+) (%W+)") and not input:find("%d+") and not input:find("%p+") then
							messages.settings.name = input
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы успешно изменили значение "..first_color.. "Имя Фамилия "..second_color.." на "..first_color.. ""..input..".", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите значение. Например: "..first_color.."Аркадий Котов.", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 1 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "Введите значение 'Звание'\nПримечание: необходимо вводить русскими буквами\nНапример: Майор", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+)") and not input:find("%d+") and not input:find("%p+") and not input:find("%s+") then
							messages.settings.rank = input
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы успешно изменили значение "..first_color.. "Звание "..second_color.." на "..first_color.. ""..input..".", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите значение. Например: "..first_color.."Майор.", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 2 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "Введите значение 'Тег'\nПримечание: необходимо вводить без скобок, русскими буквами\nНапример: М (Майор)", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+)") and not input:find("%d+") then
							messages.settings.tag = "["..input.."]"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы успешно изменили значение "..first_color.. "Тэг "..second_color.." на "..first_color.. "["..input.."].", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите значение. Например: "..first_color.."М (Майор).", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 3 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "Введите значение 'Департамент'\nПримечание: необходимо вводить русскими буквами\nНапример: МотоБатальон", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- Ожидание закрытия диалога
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+)") and not input:find("%d+") and not input:find("%p+") and not input:find("%s+") then
							messages.settings.deparament = input
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы успешно изменили значение "..first_color.. "Департамент "..second_color.." на "..first_color.. ""..input..".", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Введите значение. Например: "..first_color.."МВД.", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 4 then
					if messages.settings.rtag == false then
							messages.settings.rtag = true
							messages.settings.rrtag = "{00e600}Включено"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." Вы включили "..first_color.."автоматическое написание тега в рацию!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
							end
					elseif messages.settings.rtag == true then
						messages.settings.rtag = false
						messages.settings.rrtag = "{f50029}Выключено"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." Вы отключили "..first_color.."автоматическое написание тега в рацию!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end
				elseif list == 6 then
					sampShowDialog(41, name.dialog_settings,"Название\tЗначение\nУведомлять о взаимодействии с адм\t{00e600}" .. messages.settings.debug_adm, button_yes, button_no, 5)
				end
			end
		end
		
	result, button, list, input = sampHasDialogRespond(40)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 1.1 УК | Нападение на гражданское лицо.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 1.1 УК | Нападение на гражданское лицо.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 1.2 УК | Нападение на сотрудника правоохранительных органов.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 1.2 УК | Нападение на сотрудника правоохранительных органов.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 6 1.3 УК | Нападение на территорию военной базы.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 1.3 УК | Нападение на территорию военной базы.", -1)
				sampAddChatMessage("", -1)
				elseif list == 3 then
				sampSendChat("/su "..player_id.." 1 1.4 УК | Изнасилование любого гражданина.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 1.4 УК | Изнасилование любого гражданина.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
		
	result, button, list, input = sampHasDialogRespond(41)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 3 2.1 УК | Вооружённое нападение на гражданское лицо.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  3. "..second_color.."Причина:"..first_color.." 2.1 УК | Вооружённое нападение на гражданское лицо.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 5 2.2 УК | Вооружённое нападение на сотрудника правоохранительных органов.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  5. "..second_color.."Причина:"..first_color.." 2.2 УК | Вооружённое нападение на сотрудника правоохранительных органов.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 6 2.3 УК | Вооружённое нападение на двух и более гражданских лиц.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 2.3 УК | Вооружённое нападение на двух и более гражданских лиц.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
	
	result, button, list, input = sampHasDialogRespond(42)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 5 3.1 УК | Убийство гражданского лица.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  5. "..second_color.."Причина:"..first_color.." 3.1 УК | Убийство гражданского лица.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 3.2 УК | Убийство сотрудника правоохранительных органов.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 3.2 УК | Убийство сотрудника правоохранительных органов.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(43)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 4.1 УК | Попытка угона государственного или частного т/c.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 4.1 УК | Попытка угона государственного или частного т/c.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 3 4.2 УК | Угон государственного или частного т/c.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  3. "..second_color.."Причина:"..first_color.." 4.2 УК | Угон государственного или частного т/c.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end		
		
	result, button, list, input = sampHasDialogRespond(44)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 5.1 УК | Дача или попытка дачи взятки должностному лицу.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 5.1 УК | Дача или попытка дачи взятки должностному лицу.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 5 5.2 УК | Получение взятки должностным лицом.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  5. "..second_color.."Причина:"..first_color.." 5.2 УК | Получение взятки должностным лицом.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(45)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 6.1 УК | Ношение оружия в открытом виде.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 6.1 УК | Ношение оружия в открытом виде.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 3 6.2 УК | Получение взятки должностным лицом.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  3. "..second_color.."Причина:"..first_color.." 6.2 УК | Получение взятки должностным лицом.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 5 6.3 УК | Нелегальная покупка, перевозка, продажа оружия.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  5. "..second_color.."Причина:"..first_color.." 6.3 УК | Нелегальная покупка, перевозка, продажа оружия.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
	

	result, button, list, input = sampHasDialogRespond(46)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 6 7.1 УК | Взятие одного или группы заложников.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 7.1 УК | Взятие одного или группы заложников.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end		

		
	result, button, list, input = sampHasDialogRespond(47)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 8.1 УК | Неподчинение сотруднику правоохранительных органов, находящемуся при исполнении.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 8.1 УК | Неподчинение сотруднику правоохранительных органов, находящемуся при исполнении.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 2 8.2 УК | Неподчинение сотруднику правоохранительных органов при обстановке ЧС в Нижегородской области, а так же при проведении спец. операции.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 8.2 УК | Неподчинение сотруднику правоохранительных органов при обстановке ЧС в Нижегородской области, а так же при проведении спец. операции.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	

	result, button, list, input = sampHasDialogRespond(48)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 2 9.1 УК | Проникновение на территорию, охраняемую правоохранительными органами.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 9.1 УК | Проникновение на территорию, охраняемую правоохранительными органами.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 1 9.2 УК | Проникновение на частную территорию без разрешения владельца.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 9.2 УК | Проникновение на частную территорию без разрешения владельца.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 4 9.3 УК | Проникновение на территорию закрытой военной базы.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 9.3 УК | Проникновение на территорию закрытой военной базы.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(49)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 4 10.1 УК | Хранение и/или перевозка наркотических веществ.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 10.1 УК | Хранение и/или перевозка наркотических веществ.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 10.2 УК | Сбыт, распространение, приобретение наркотических веществ.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 10.2 УК | Сбыт, распространение, приобретение наркотических веществ.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 3 10.3 УК | Употребление наркотических веществ.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  3. "..second_color.."Причина:"..first_color.." 10.3 УК | Употребление наркотических веществ.", -1)
				sampAddChatMessage("", -1)
				elseif list == 3 then
				sampSendChat("/su "..player_id.." 6 10.4 УК | Производство/изготовление/выращивание наркотических веществ.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 10.4 УК | Производство/изготовление/выращивание наркотических веществ.", -1)
				sampAddChatMessage("", -1)
				elseif list == 4 then
				sampSendChat("/su "..player_id.." 1 10.5 УК | Хранение/распространение семян марихуаны.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 10.5 УК | Хранение/распространение семян марихуаны.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
				

	result, button, list, input = sampHasDialogRespond(50)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 6 11.1 УК | Планирование/исполнение теракта.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 11.1 УК | Планирование/исполнение теракта.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 1 11.2 УК | Заведомо ложное сообщение о теракте.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 11.2 УК | Заведомо ложное сообщение о теракте.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 4 11.3 УК | Специальный подрыв с помощью ТС или лётного транспорта.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 11.3 УК | Специальный подрыв с помощью ТС или лётного транспорта (сброс самолётов/вертолётов).", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(51)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 2 12.1 УК | Отказ от уплаты штрафа.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 12.1 УК | Отказ от уплаты штрафа.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	

	result, button, list, input = sampHasDialogRespond(52)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 13.1 УК | Порча имущества гражданских лиц, государственных организаций.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 13.1 УК | Порча имущества гражданских лиц, государственных организаций.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 2 13.2 УК | Порча/Уничтожение муниципального имущества.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 13.2 УК | Порча/Уничтожение муниципального имущества (столбов, скамеек, остановок).", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end

	result, button, list, input = sampHasDialogRespond(53)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 3 14.1 УК | Проявление национализма, расизма.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  3. "..second_color.."Причина:"..first_color.." 14.1 УК | Проявление национализма, расизма.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(54)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 2 15.1 УК | Планирование/Реализация/Соучастие в несанкционированных митингах либо бунтах.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 15.1 УК | Планирование/Реализация/Соучастие в несанкционированных митингах либо бунтах.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 15.2 УК | Вооруженное насилие, а так же призывы к насилию на митингах.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 15.2 УК | Вооруженное насилие, а так же призывы к насилию на митингах.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 2 15.3 УК | Срыв одобренного мероприятия, помеха проведению одобренного мероприятия.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 15.3 УК | Срыв одобренного мероприятия, помеха проведению одобренного мероприятия.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(55)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 16.1 УК | Управление т/с в состоянии алкогольного и/или наркотического опьянения.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 16.1 УК | Управление т/с в состоянии алкогольного и/или наркотического опьянения.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end			
		
	result, button, list, input = sampHasDialogRespond(56)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 2 17.1 УК | Вымогательство денежных средств, частной собственности.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 17.1 УК | Вымогательство денежных средств, частной собственности.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 17.2 УК | Вымогательство денежных средств, частной собственности должностным лицом.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 17.2 УК | Вымогательство денежных средств, частной собственности должностным лицом.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end		

	result, button, list, input = sampHasDialogRespond(57)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 18.1 УК | Помеха сотруднику правоохранительных органов.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 18.1 УК | Помеха сотруднику правоохранительных органов.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end		

	result, button, list, input = sampHasDialogRespond(58)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 19.1 УК | Явка с повинной.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 19.1 УК | Явка с повинной ((с 2-4 уровнем розыска)), преступнику сокращают срок прибывания в тюрьме на 1 год.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 19.2 УК | Явка с повинной.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 19.2 УК | Явка с повинной ((с 5-6 уровнем розыска)), преступнику сокращают срок прибывания в тюрьме на 1 год.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end				
		
	result, button, list, input = sampHasDialogRespond(59)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 2 20.1 УК | Кража частного имущества.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  2. "..second_color.."Причина:"..first_color.." 20.1 УК | Кража частного имущества.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 20.2 УК | Кража гос. собственности, собственности организаций, имущества, материалов.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 20.2 УК | Кража гос. собственности, собственности организаций, имущества, материалов.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
	
	result, button, list, input = sampHasDialogRespond(60)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 21.1 УК | Отказ предъявить паспорт.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  1. "..second_color.."Причина:"..first_color.." 21.1 УК | Отказ предъявить паспорт.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(61)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 4 22.1 УК | Соучастие в преступлении.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  4. "..second_color.."Причина:"..first_color.." 22.1 УК | Соучастие в преступлении.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
	
	
	result, button, list, input = sampHasDialogRespond(62)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 6 23.1 УК | Шпионаж/Продажа/Слив государственной информации.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 23.1 УК | Шпионаж/Продажа/Слив государственной информации.", -1)
				sampAddChatMessage("", -1)
			elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 23.2 УК | Передача гос. информации преступным группировкам.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.."  6. "..second_color.."Причина:"..first_color.." 23.2 УК | Передача гос. информации преступным группировкам.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
	
	
	result, button, list, input = sampHasDialogRespond(63)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 24.1 УК | Попытка покончить жизнь самоубийством.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.." 1. "..second_color.."Причина:"..first_color.." 24.1 УК | Попытка покончить жизнь самоубийством.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
	
	result, button, list, input = sampHasDialogRespond(64)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 2 25.1 УК | Уклонение от воинской службы.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.." 2. "..second_color.."Причина:"..first_color.." 25.1 УК | Уклонение от воинской службы.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
	
	result, button, list, input = sampHasDialogRespond(65)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 6 26.1 УК | До выяснения.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обьявили игрока "..first_color..""..player_name.." ["..player_id.."]"..second_color.." в федеральный розыск.", -1)
				sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.." 6. "..second_color.."Причина:"..first_color.." 26.1 УК | До выяснения.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
		
	result, button, list, input = sampHasDialogRespond(67) -- взаимодействие и диалогом ID 4
	
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(68, name.dialog_mstroy_1, dialog.mstroy_1, button_yes, button_no, 2)
				elseif list == 1 then
					sampShowDialog(69, name.dialog_mstroy_2, dialog.mstroy_2, button_yes, button_no, 2)
				end
			end
		end
	
	result, button, list, input = sampHasDialogRespond(68) -- взаимодействие и диалогом ID 4
	
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function()
						sampSendChat("/s Сейчас я расскажу Вам что такое проверка и правила поведения на ней. ")
						wait(1000)
						sampSendChat("/s Проверка - это средство контроля, за исполнением законов.")
						wait(1000)
						sampSendChat("/s Ее проводят 4 государственных организаций: МВД, МЧС, МЗ, Пра-во.")
						wait(1000)
						sampSendChat("/s На проверке запрещено: ")
						wait(1000)
						sampSendChat("/s 1. Разговаривать в строю по телефону. ")
						wait(1000)
						sampSendChat("/s 2. Разговаривать в строю с сослуживцами или другими гражданами. ")
						wait(1000)
						sampSendChat("/s 3. Покидать строй без разрешения руководителя. ")
						wait(1000)
						sampSendChat("/s 4. Входить в строй без разрешения руководителя. ")
						wait(1000)
						sampSendChat("/s 5. Опаздывать на строй без разрешения руководителя или ув. причины. ")
						wait(1000)
						sampSendChat("/s 6. Всяечки мешать своим коллегам и проверяющим. ")
						wait(1000)
						sampSendChat("/s На этом лекция на тему 'Проверка' окончена.")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 1 then
					lua_thread.create(function()
						sampSendChat("Здравия желаю! Сейчас будет лекция! Тема лекции: Проверка документов!")
						wait(1000)
						sampSendChat("Проверять документы можно на постах и в общественных местах.")
						wait(1000)
						sampSendChat("Подразделение ДПС может проверять документы для отчётов на повышение только на постах")
						wait(1000)
						sampSendChat("Подразделение МБ может проверять документы в любом месте.")
						wait(1000)
						sampSendChat("Подразделение ППС может проверять документы на постах ППС и в общественных местах.")
						wait(1000)
						sampSendChat("Для проверки документов вы обязаны сообщить гражданину основание.")
						wait(1000)
						sampSendChat("Если у вас есть основание что он в розыске то вы обязаны предъявить ориентировку")
						wait(1000)
						sampSendChat("а затем попросить предоставить его свой паспорт.")
						wait(1000)
						sampSendChat("ДПС и МБ могут запросить документы на ТС")
						wait(1000)
						sampSendChat("если есть подозрение что авто в угоне,")
						wait(1000)
						sampSendChat("а так же для проверки находясь на посту ДПС.")
						wait(1000)
						sampSendChat("На этом лекция окончена. Вопросы есть?")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 2 then
					lua_thread.create(function()
						sampSendChat("/s Лекция на тему Суббординация!")
						wait(1000)
						sampSendChat("Субординация - это служебные отношения, построенные по принципу иерархичности.")
						wait(1000)
						sampSendChat("Обращение к старшему по званию выполняется строго по званию")
						wait(1000)
						sampSendChat("Пример: т. Капитан, т. Генерал и т.д.")
						wait(1000)
						sampSendChat("Для положительного ответа используют фразы: Так точно, Есть.")
						wait(1000)
						sampSendChat("Запрещены фразы: Ок, Хорошо, Ладно и т.д.")
						wait(1000)
						sampSendChat("Для отрицательного ответа используют фразу: Никак нет.")
						wait(1000)
						sampSendChat("Запрещены фразы: Нет, Не хочу, Не буду и т.д.")
						wait(1000)
						sampSendChat("Для приветствия используют фразу: Здравия желаю.")
						wait(1000)
						sampSendChat("Запрещены фразы: Ку, Привет, Здорово и т.д.")
						wait(1000)
						sampSendChat("Для извинения используют фразы: Виноват, Исправлюсь.")
						wait(1000)
						sampSendChat("Запрещены фразы: Сори, Извините, Простите и т.д.")
						wait(1000)
						sampSendChat("Для обращения к старшему по званию используют фразу: Разрешите обратиться?")
						wait(1000)
						sampSendChat("Все личные вопросы решаются в нерабочее время.")
						wait(1000)
						sampSendChat("На этом лекция окончена. Вопросы есть?")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 3 then
					lua_thread.create(function()
						sampSendChat("/s Здравия желаю! Сейчас будет лекция! Тема лекции: Пост!")
						wait(1000)
						sampSendChat("Существует несколько типов постов: для Академии, ДПС и ППС.")
						wait(1000)
						sampSendChat("Для подразделения академия посты 'Вход' и 'КПП'.")
						wait(1000)
						sampSendChat("Для подразделения ДПС, МБ, СЭ посты на трассах с будками и шлагбаумами.")
						wait(1000)
						sampSendChat("Для подразделения ППС, ОМОН, ОКН посты на вокзалах, общественных местах.")
						wait(1000)
						sampSendChat("В одиночку стоять на постах нежелательно, нужен напарник.")
						wait(1000)
						sampSendChat("Исключение: с 00:00 до 6:00.")
						wait(1000)
						sampSendChat("Доклады в рацию должны звучать каждые 10 минут и включать в себя:")
						wait(1000)
						sampSendChat("1. Напарника или напарников. Называете номер жетона.")
						wait(1000)
						sampSendChat("2. Состояние. Стабильное, ЧП.")
						wait(1000)
						sampSendChat("На этом лекция окончена. Вопросы есть?")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 4 then
					lua_thread.create(function()
						sampSendChat("/s Сейчас пройдет тренировка!")
						wait(1234)
						sampSendChat("/c 60")
						sampSendChat("/n Для засчитывания её в отчете Вам требуется: ")
						wait(1234)
						sampSendChat("/n >> Минимум 3 отыгровки на каждое действие.")
						wait(1234)
						sampSendChat("/n >> Не спать, не мешать другим.")
						wait(1234)
						sampSendChat("/n >> Но самое главное: быть. просто быть :)")
						wait(1234)
						sampSendChat("/s Первое упражнение: разминка шеи и головы")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Второе упражнение: разминка рук")
						wait(1000)
						sampSendChat("/n /anim 6 7 || /anim 6 21")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Молодцы, закончили. Следующее упражнение: разминка ног")
						wait(1000)
						sampSendChat("/n Спамьте /anim 6 20")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Великолепно! Сейчас начнем приседания")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Продолжаем! Отжимания.")
						wait(1000)
						sampSendChat("/n /anim 6 23")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Закончили! Начинайте выполнять восточную медитацию")
						wait(1000)
						sampSendChat("/n /anim 8 2")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Теперь прыжки в длину. Начали!")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s Ходьба гусиным шагом. Полторы минуты!")
						wait(1234)
						sampSendChat("/c 60")
						wait(90000)
						sampSendChat("/s Последнее упражнение бег по плацу. Также полторы минуты!")
						wait(1234)
						sampSendChat("/c 60")
						wait(90000)
						sampSendChat("/s Вы в хорошей форме, бойцы. Тренировка окончена.")
					end)	
				elseif list == 7 then
					lua_thread.create(function()
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
						sampSendChat("")
						wait(1000)
					end)
				
				end
			end
		end	
		
	end
end
	
function cmd_mid(params) -- /mid
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте "..first_color.."/mid [ID игрока].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				ready_player = 0
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы выбрали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."для дальнейшей работы.", -1)
				sampAddChatMessage("", -1)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
 
 function cmd_msu(params) --/msu
    local id, level, reason = string.match(params, "(%d+) (%d+) (.+)")
		if id == nil or level == nil or reason == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.."/msu [ID игрока] [уровень розыска (В случае ручного ввода причины)]", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(id) then
				player_id = id
				player_name = sampGetPlayerNickname(player_id)
				if level == "0" and reason == "0" then
					sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me достал КПК из сумки")
						wait(777)
						sampSendChat("/me сохранил фоторобот подозреваемого, перемещая его в базу")
						wait(777)
						sampSendChat("/do Подозреваемый опознан.")
						wait(777)
						sampSendChat("/me объявляет подозреваемого в федеральный розыск")
					end)
				else 
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы объявили игрока "..first_color..""..player_name.." ["..mid.."]"..second_color.." в федеральный розыск.", -1)
					sampAddChatMessage(short_script_name.." Уровень розыска:"..first_color.." "..level..". "..second_color.."Причина:"..first_color.." "..reason, -1)
					sampAddChatMessage("", -1)
					sampSendChat(string.format("/su %d %d %s", id, level, reason), -1)
					sampAddChatMessage(string.format(service.." /su %d %d %s", id, level, reason), -1) -- Debug
					lua_thread.create(function()
						sampSendChat("/me достал КПК из сумки")
						wait(777)
						sampSendChat("/me сохранил фоторобот подозреваемого, перемещая его в базу")
						wait(777)
						sampSendChat("/do Подозреваемый опознан.")
						wait(777)
						sampSendChat("/me объявляет подозреваемого в федеральный розыск")
					end)
				end
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end	
		end
	end

function cmd_mticket(params) --/mticket
    local id, amount, reason = string.match(params, "(%d+) (%d+) (.+)")
		if id == nil or amount == nil or reason == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.."/mticket [ID игрока] [уровень розыска (В случае ручного ввода причины)]", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(id) then
				player_id = id
				player_name = sampGetPlayerNickname(player_id)
				if amount == "0" and reason == "0" then
					tickets = 0
					reason1 = ""
					reason2 = ""
					reason3 = ""
					price = 0
					sampShowDialog(10, name.dialog_koap, dialog.koap, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me достал КПК из сумки")
						wait(777)
						sampSendChat("/me открыл базу штрафных квитанций")
						wait(777)
						sampSendChat("/me заполняет штрафную квитанцию")
						wait(777)
						sampSendChat("/todo Отправляя штрафную квитанцию*выслал реквизиты для оплаты Вам на эл. почту")
						wait(777)
						sampSendChat("Вам необходимо оплатить штраф в течении трех дней, иначе наши сотрудники ...")
						wait(777)
						sampSendChat(" ...аннулируют Ваше водительское удостоверение. Всего доброго, не нарушайте!")
					end)
				else
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." Вы выдали игроку "..first_color..""..player_name.." ["..mid.."]"..second_color.." штраф.", -1)
					sampAddChatMessage(short_script_name.." Сумма:"..first_color.." "..amount..". "..second_color.."Причина:"..first_color.." "..reason, -1)
					sampAddChatMessage("", -1)
					sampSendChat(string.format("/ticket %d %d %s", id, amount, reason), -1)
					sampAddChatMessage(string.format(service.." /ticket %d %d %s", id, amount, reason), -1) -- Debug
					lua_thread.create(function()
						sampSendChat("/me достал КПК из сумки")
						wait(777)
						sampSendChat("/me открыл базу штрафных квитанций")
						wait(777)
						sampSendChat("/me заполняет штрафную квитанцию")
						wait(777)
						sampSendChat("/todo Отправляя штрафную квитанцию*выслал реквизиты для оплаты Вам на эл. почту")
						wait(777)
						sampSendChat("Вам необходимо оплатить штраф в течении трех дней, иначе наши сотрудники ...")
						wait(777)
						sampSendChat(" ...аннулируют Ваше водительское удостоверение. Всего доброго, не нарушайте!")
					end)
				end
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end	
		end
	end

function cmd_msm(arg) -- /msm
	if #arg == 0 then
		if msm == true then
			msm = not msm
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Вы закончили преследовать игрока "..first_color..""..player_name.." ["..player_id.."].", -1)
			sampAddChatMessage("", -1)
		else
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.."/msm [ID игрока]", -1)
			sampAddChatMessage("", -1)
		end
	else
		if sampIsPlayerConnected(arg) then
			player_id = arg
			player_name = sampGetPlayerNickname(player_id)
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Вы начали преследовать игрока "..first_color..""..player_name.." ["..player_id.."].", -1)
			sampAddChatMessage(short_script_name.." Чтобы закончить преследование, используйте "..first_color.."/msm", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function()
				sampSendChat("/me взял в руки планшет")
				wait(777)
				sampSendChat("/me включил программу 'Федеральный розыск'")
				wait(777)
				sampSendChat("/do Загрузка.. ")
				wait(777)
				sampSendChat("/me получил данные из списка подозреваемых")
				wait(777)
				sampSendChat("/do Данные получены.")
				wait(1000)
				msm = not msm
			end)
		else
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
			sampAddChatMessage("", -1)
		end
	end
end	 

function cmd_pg(arg) --/pg
	if sampIsPlayerConnected(id) then
		player_id = arg
		player_name = sampGetPlayerNickname(player_id)
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." Вы начали погоню за игроком "..first_color..""..player_name.." ["..player_id.."].", -1)
		sampAddChatMessage("", -1)
		sampSendChat("/pg "..arg, -1)
		sampAddChatMessage("/pg "..arg, -1) -- Debug
		lua_thread.create(function()
			sampSendChat("/me достал рацию из рюкзака.")
			wait(777)
			sampSendChat("/do Рация в руке.")
			wait(777)
			sampSendChat("/me доложил диспечеру, что начал погоню за нарущителем")
		end)
	else
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
		sampAddChatMessage("", -1)
	end	
end

function cmd_putpl(params) -- /putpl
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте "..first_color.."/putpl [ID игрока].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы посадили игрока "..first_color..""..player_name.." ["..player_id.."] "..second_color.."в патрульный автомобиль.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/me слегка протянув правую руку вперед, открыл дверь автомобиля")
					wait(777)
					sampSendChat("/do Дверь полицейского автомобиля открыта.")
					wait(777)
					sampSendChat("/me посадил "..player_name.." в автомобиль.")
					wait(777)
					sampSendChat("/do "..player_name.." находится в полицейском автомобиле.")
					wait(777)
					sampSendChat("/me легким движением руки закрыл дверь автомобиля")
					wait(777)
					sampSendChat("/do  Дверь полицейского автомобиля закрыта.")
					wait(777)
					sampSendChat("/putpl "..mid)
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_arrest(params) -- /arrest
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте "..first_color.."/arrest [ID игрока].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы арестовали игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."в патрульный автомобиль.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/me открыл двери полицейского участка")
					wait(777)
					sampSendChat("/do Двери открыты.")
					wait(777)
					sampSendChat("/me проводел "..player_name.." в камеру")
					wait(777)
					sampSendChat("/do "..player_name.." под заключением.")
					wait(777)
					sampSendChat("/me легким движением руки закрыл дверь участка")
					wait(777)
					sampSendChat("/do  Дверь полицейского участка закрыта.")
					wait(777)
					sampSendChat("/arrest "..mid)
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_ejectout(params) -- /ejectout
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте "..first_color.."/mejectout [ID игрока].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage(short_script_name.." Вы вытащили игрока "..first_color..""..player_name.." ["..mid.."] "..second_color.."из автомобиля.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/do Стекло автомобиля целое.")
					wait(777)
					sampSendChat("/ejectout "..mid)
					wait(777)
					sampSendChat("/todo Точным ударом разбивая стекло*Раз не захотели сами выходить. Поможем!")
					wait(777)
					sampSendChat("/do Стекло разбито")
					wait(777)
					sampSendChat("/me открыл дверь через салон и вытащил человека из автомобиля")
					wait(777)
					sampSendChat("/do Человек стоит на улице.")
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_search(params) -- /search
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте "..first_color.."/msearch [ID игрока].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы обыскиваете игрока "..first_color..""..player_name.." ["..mid.."] "..second_color..".", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/do Нашивка сотрудника МВД на груди")
					wait(777)
					sampSendChat("/me достал ордер на обыск и показал его человеку напротив")
					wait(777)
					sampSendChat("Повернитесь спиной, подняв руки. Без резких движений!")
					wait(777)
					sampSendChat("/me надел перчатки на руки")
					wait(777)
					sampSendChat("/me открыл дверь через салон и вытащил человека из автомобиля")
					wait(777)
					sampSendChat("/me проводит руками по верхней части тела")
					wait(777)
					sampSendChat("/me проводит руками по туловищу")
					wait(777)
					sampSendChat("/anim 5 1")
					wait(777)
					sampSendChat("/me проводит руками по нижней части тела")
					wait(777)
					sampSendChat("/do Обыск завершен.")
					wait(777)
					sampSendChat("Подведем итоги обыска..")
					wait(777)
					sampSendChat("/search "..mid)
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_takelic(params) --/takelic
    local id, reason = string.match(params, "(%d+) (.+)")
		if id == nil or reason == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.."/mtakelic [ID игрока] [причина]", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(id) then
				player_id = id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Вы лишили игрока "..first_color..""..player_name.." ["..player_id.."] "..second_color.." водительского удостоверения.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/me достал КПК из сумки")
					wait(777)
					sampSendChat("/me открыл базу нарушений")
					wait(777)
					sampSendChat("/me заполняет информацию о нарушении и нарушителе")
					wait(777)
					sampSendChat("/do Данные актуализированы.")
					wait(777)
					sampSendChat("/me забрал водительское удостоверение")
					wait(777)
					sampSendChat("/do Водительское удостоверение забрано.")
					wait(777)
					sampSendChat(string.format("/takelic %d %s", id, reason), -1)
					sampAddChatMessage(string.format(service.." /takelic %d %s", id, reason), -1) -- Debug
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." Такого игрока нет!", -1)
				sampAddChatMessage("", -1)
			end	
		end
	end

function cmd_hidechat() 
	sampShowDialog(6, name.dialog_hide_chat, "Название чата\tЗначение\nЧат дальнобойщиков\t" .. messages.settings.rchattc .. "\nУведомления от ТРК\t" .. messages.settings.rchattrk .. "\nНаказания от администрации\t" .. messages.settings.rchatadm .. "\nРация организации\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
end

function cmd_settings()
	sampShowDialog(36, name.dialog_settings,"Название\tЗначение\nИмя Фамилия\t{00e600}" .. messages.settings.name .. "{ffffff}\nЗвание\t{00e600}" .. messages.settings.rank .. "{ffffff}\nТег\t{00e600}" .. messages.settings.tag .. "{ffffff}\nДепартамент\t{00e600}" .. messages.settings.deparament .. "{ffffff}\nАвтоматический тег в рацию\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
end

function cmd_test2()
	sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
end

function cmd_test() 
	tickets = 0
					reason1 = ""
					reason2 = ""
					reason3 = ""
					price = 0
					sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
end
function cmd_test3() 
	sampAddChatMessage("[14:47:09] Timofey_Nahumovich[385] крикнул: Спец. задание!",-1)
end

function cmd_mstroy()
	sampShowDialog(67, name.dialog_mstroy, dialog.mstroy, button_yes, button_no, 2)
end

-- полный дебаг тута
-- ID ДИАЛОГОВ
-- 2 - один из основных диалогов (проверка документов)
-- 3 - один из основных диалогов (принять игрока)
-- 4 - один из основных диалогов (отпустить игрока и тд)
-- 5 - один из основных диалогов (остальное ахк)
-- 6 - диалог скрытия чатов
-- 10 - диалог КоАП
-- 11-24 - статьи КоАПа
-- 25 - диалог повторной выдачи штрафа КоАП
-- 26 ацепт выдачи штрафа
-- 27 ввод причины лишения ВУ
-- 30 ввод причины розыска
-- 31 выбор причины розыска
-- 32 level su
-- 33 проверка ID
-- 34 ввод id
-- 35
-- 36 меню настроек
-- 37 изменеие настррое
-- 38 ввод ticket
-- 39 ввод amount ticket
-- 40-66 su
-- 41 debug
-- 67 Мени строя
-- 68-69
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--

function cmd_r(str)
	if messages.settings.rtag == true then
		if messages.settings.tag ~= "{f50029}Не указано" and #str >= 1 then
			sampSendChat(string.format("/r %s %s", messages.settings.tag, str))
		elseif messages.settings.tag == "{f50029}Не указано" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Вы не настроили скрипт.", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/msettings ", -1)
			sampAddChatMessage("", -1)
		elseif #str == 0 then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/r [Сообщение] ", -1)
			sampAddChatMessage("", -1)
		end
	elseif messages.settings.rtag == false then
		if  #str >= 1 then
			sampSendChat(string.format("/r %s", str))
		elseif #str == 0 then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/r [Сообщение] ", -1)
			sampAddChatMessage(short_script_name.." У вас отключена функция "..first_color.."автоматического ввода тега в рацию!", -1)
			sampAddChatMessage("", -1)
		end
	end
end

function cmd_d(params)


local id, text = string.match(params, "(%d+) (.+)")
	if id == nil or text == "" then
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." Используйте: "..first_color.. "/d [ID организации] [Сообщение] ", -1)
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." Список организаций: ", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."0"..second_color.." - "..first_color.."Общая волна департамента", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."1"..second_color.." - "..first_color.."Правительство", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."2"..second_color.." - "..first_color.."Министерство Обороны", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."3"..second_color.." - "..first_color.."Министерство Здравоохранения", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."4"..second_color.." - "..first_color.."ТРК 'Ритм'", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."5"..second_color.." - "..first_color.."Министерство Чрезвычайных Ситуаций", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."6"..second_color.." - "..first_color.."Федеральная Служба Исполнения Наказаний", -1)
		sampAddChatMessage("", -1)
	else
		if id == "0" then
			sampSendChat(string.format("/d [МВД] - [ОВД] %s", text), -1)
		elseif id == "1" then 
			sampSendChat(string.format("/d [МВД] - [Пра-во] %s", text), -1)
		elseif id == "2" then 
			sampSendChat(string.format("/d [МВД] - [МО] %s", text), -1)
		elseif id == "3" then 
			sampSendChat(string.format("/d [МВД] - [МЗ] %s", text), -1)
		elseif id == "4" then 
			sampSendChat(string.format("/d [МВД] - [ТРК] %s", text), -1)
		elseif id == "5" then 
			sampSendChat(string.format("/d [МВД] - [МЧС] %s", text), -1)
		elseif id == "6" then 
			sampSendChat(string.format("/d [МВД] - [ФСИН] %s", text), -1)
		end
	end

end

function test3(arg)
	player_name = sampGetPlayerNickname(arg)
	sampAddChatMessage(rusnick(player_name), -1)
	sampAddChatMessage(player_name, -1)
end

function rusnick(name) -- debug chel
if name:match('%a+') then
        for k, v in pairs(trstl1) do
            name = name:gsub(k, v) 
        end
        for k, v in pairs(trstl) do
            name = name:gsub(k, v) 
        end
        return name
    end
 return name
end 

function getNearestID()
    local chars = getAllChars()
    local mx, my, mz = getCharCoordinates(PLAYER_PED)
    local nearId, dist = nil, 10000
    for i,v in ipairs(chars) do
        if doesCharExist(v) and v ~= PLAYER_PED then
            local vx, vy, vz = getCharCoordinates(v)
            local cDist = getDistanceBetweenCoords3d(mx, my, mz, vx, vy, vz)
            local r, id = sampGetPlayerIdByCharHandle(v)
            if r and cDist < dist then
                dist = cDist
                nearId = id
            end
        end
    end
    return nearId
end

function patrul(arg)
		sampAddChatMessage("{33cc66}[R] Капитан Arkady_Kotow[136]: [К] Докладывает: Котов | Стою на посту КПЗ | Состояние: стабильное.")
		sampSendChat("/c 60")
end
	

require('samp.events').onServerMessage = function(color, text)
	messages = inicfg.load(nil, directIni)
	if messages.settings.chattc == false then
		if text:match('[Компания]') and text:match('дальнобойщик') or text:match('[Компания]') and text:match('Заместитель') or text:match('[Компания]') and text:match('Владелец') then 
			return false
		end
	end
	if messages.settings.chatadm == false then
		if text:match('Администратор') and text:match('Причина:') then  
			return false
		end
	end
	if messages.settings.chattrk == false then
		if text:match('Объявление проверил сотрудник СМИ') then  
			return false
		end
		if text:match('ТРК Ритм') or text:match('Отправил') and text:match('т.') and text:match('') then  
			return false
		end
	end
	if messages.settings.chatorg == false then
		if text:match('[R]') and text:match('Генерал') or text:match('Полковник') or text:match('Подполковник') or text:match('Майор') or text:match('Капитан') or text:match('Лейтенант') or text:match('Прапорщик') or text:match('Сержант') or text:match('Ефрейтор') or text:match('Рядовой') then  
			return false
		end
	end
	if messages.settings.admnotif == true then
		if (text:find('Администратор') and text:find(':') and text:find('для')) or text:find('%[A%]') then
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
			sampAddChatMessage("НАПИСАЛ АДМИН", -1)
		end
	end
end


function cmd_stroy(arg)
	lua_thread.create(function()
		sampSendChat("/r "..messages.settings.tag.. " Строй на плацу! Готовность - "..arg.. " мин. Кого нет - выговор!")
		wait(60000)
		arg1 = arg - 1
		if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " Строй объявлен!")
		else
			sampSendChat("/r "..messages.settings.tag.. " Строй на плацу! Готовность - "..arg1.. " мин. Кого нет - выговор!")
			arg1 = arg - 2
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " Строй объявлен!")
			else
			sampSendChat("/r "..messages.settings.tag.. " Строй на плацу! Готовность - "..arg1.. " мин. Кого нет - выговор!")
			arg1 = arg - 3
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " Строй объявлен!")
			else
			sampSendChat("/r "..messages.settings.tag.. " Строй на плацу! Готовность - "..arg1.. " мин. Кого нет - выговор!")
			arg1 = arg - 4
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " Строй объявлен!")
			else
			sampSendChat("/r "..messages.settings.tag.. " Строй на плацу! Готовность - "..arg1.. " мин. Кого нет - выговор!")
			arg1 = arg - 5
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " Строй объявлен!")
			else
			sampSendChat("/r "..messages.settings.tag.. " Строй на плацу! Готовность - "..arg1.. " мин. Кого нет - выговор!")
			end
			end
			end
			end
		end
	end)
end
