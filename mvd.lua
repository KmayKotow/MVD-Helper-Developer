require "lib.moonloader"
local keys = require "vkeys"
local trstl1 = {['ph'] = '�',['Ph'] = '�',['Ch'] = '�',['ch'] = '�',['Th'] = '�',['th'] = '�',['Sh'] = '�',['sh'] = '�', ['ea'] = '�',['Ae'] = '�',['ae'] = '�',['size'] = '����',['Jj'] = '��������',['Whi'] = '���',['whi'] = '���',['Ck'] = '�',['ck'] = '�',['Kh'] = '�',['kh'] = '�',['hn'] = '�',['Hen'] = '���',['Zh'] = '�',['zh'] = '�',['Yu'] = '�',['yu'] = '�',['Yo'] = '�',['yo'] = '�',['Cz'] = '�',['cz'] = '�', ['ia'] = '�', ['ea'] = '�',['Ya'] = '�', ['ya'] = '�', ['ove'] = '��',['ay'] = '��', ['rise'] = '����',['oo'] = '�', ['Oo'] = '�', ['Arkady'] = '�������', ['Alexsander'] = '���������', ['Extrasize'] = '����������', ['Ch'] = '�',['Alosha'] = '�����', ['ia'] = '��', ['Alexander'] = '���������',['Brown'] = '�����', ['Luxury'] = '�������', ['Cha'] = '��', ['Ch'] = '�'}
local trstl = {['B'] = '�',['Z'] = '�',['T'] = '�',['Y'] = '�',['P'] = '�',['J'] = '��',['X'] = '��',['G'] = '�',['V'] = '�',['H'] = '�',['N'] = '�',['E'] = '�',['I'] = '�',['D'] = '�',['O'] = '�',['K'] = '�',['F'] = '�',['y`'] = '�',['e`'] = '�',['A'] = '�',['C'] = '�',['L'] = '�',['M'] = '�',['W'] = '�',['Q'] = '�',['U'] = '�',['R'] = '�',['S'] = '�',['zm'] = '���',['h'] = '�',['q'] = '�',['y'] = '�',['a'] = '�',['w'] = '�',['b'] = '�',['v'] = '�',['g'] = '�',['d'] = '�',['e'] = '�',['z'] = '�',['i'] = '�',['j'] = '�',['k'] = '�',['l'] = '�',['m'] = '�',['n'] = '�',['o'] = '�',['p'] = '�',['r'] = '�',['s'] = '�',['t'] = '�',['u'] = '�',['f'] = '�',['x'] = 'x',['c'] = '�',['``'] = '�',['`'] = '�',['_'] = ' '}

-- �������� ��� ������ �������
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
local reason_takelic = "�� �������"

-- ��� ������ /msm 
local msm = false
local debug = true

-- ��������� ������� (��������)
local script_version = "{99FF33}v1.0"
local script_name = " {ffffff}AHK "..script_version.." {FFFFFF}��� �{42aaff}�{f50029}�"
local short_script_name = "�{42aaff}�{f50029}� {FFFFFF}�" 
local service = "{42aaff}Debug {FFFFFF}�" 
local notification = "{42aaff}����������� {FFFFFF}�" 

-- �������� ��������
local first_color = "{42aaff}"
local second_color = "{ffffff}"
local third_color = "{00e600}"

-- ���������� �������� � cfg
local inicfg = require 'inicfg'
directIni = '../config/mvd_ahk.ini'
messages = inicfg.load(inicfg.load({
    settings = {
		chattc = true,
		deparament = "{f50029}�� �������",
		rchatorg = "{00e600}��������",
		tag = "{f50029}�� �������",
		chatorg = true,
		rank = "{f50029}�� �������",
		rchattc = "{00e600}��������",
		chatadm = true,
		rchatadm = "{00e600}��������",
		name = "{f50029}�� �������",
		rchattrk = "{00e600}��������",
		rrtag = "{f50029}���������",
		chattrk = true,
		rtag = false,
		debug = false,
		debug_adm = "{f50029}���������",
    },
}, directIni))
inicfg.save(messages, directIni)

local users = {
    {'Arkady_Kotow', 'kmaukotow', 'admin', '����', '�������������'},
    {'Pelmen', '1488', 'user', 'none', 'player'},
    {'User', 'password', 'user', '�����', '������������'},
}
-- �������

local button_yes = "�������"
local button_no = "��������"
local button_confirm = "������"

local name = { }
name.dialog_main_1 = "�������������� � "..player_name.." ["..mid.."]"
name.dialog_main_2 = "��������������"
name.dialog_hide_chat = "��������� �����"
name.dialog_confirm = "�������������"
name.dialog_double_koap = "�������� ���-�� ���?"
name.dialog_koap = "������ �� ���������������� ���������������"
name.dialog_uk = "��������� ������"
name.dialog_koap_1 = "���� � ��������� ����������� ������"
name.dialog_koap_2 = "���� � ���� �� ��������� ������"
name.dialog_koap_3 = "���� � ������ �������� ������� ���������"
name.dialog_koap_4 = "���� � �������� � ������������ �����"
name.dialog_koap_5 = "���� � �������� � ������������ �����, �������� �� �������� �� ����� ��������"
name.dialog_koap_6 = "���� � ������������� ����� ����. ����� � ����������"
name.dialog_koap_7 = "���� � ����������� ��������, ���������� ������������ ���������"
name.dialog_koap_8 = "���� � ����������� ��������, ���������� ������������ ���������"
name.dialog_koap_9 = "���� � ����������� ��������"
name.dialog_koap_10 = "���� � ��������������� ����"
name.dialog_koap_11 = "���� � ���� � ��������� ����"
name.dialog_koap_12 = "���� � ������ ������������ � ����"
name.dialog_koap_13 = "���� � ���������"
name.dialog_koap_14 = "���� � ����� �������������� ����������"
name.dialog_uk_1 = "�� � ���������"
name.dialog_uk_2 = "�� � ����������� ���������"
name.dialog_uk_3 = "�� � ��������"
name.dialog_uk_4 = "�� � ����"
name.dialog_uk_5 = "�� � ������"
name.dialog_uk_6 = "�� � ������"
name.dialog_uk_7 = "�� � ������ � ���������"
name.dialog_uk_8 = "�� � ������������"
name.dialog_uk_9 = "�� � �������������"
name.dialog_uk_10 = "�� � ������������� ��������"
name.dialog_uk_11 = "�� � ���������"
name.dialog_uk_12 = "�� � ��������� �� ������ ������"
name.dialog_uk_13 = "�� � �����������"
name.dialog_uk_14 = "�� � ���������� ������������ ���������"
name.dialog_uk_15 = "�� � �������"
name.dialog_uk_16 = "�� � �������� � ��������� ����"
name.dialog_uk_17 = "�� � ��������������"
name.dialog_uk_18 = "�� � ������"
name.dialog_uk_19 = "�� � ������"
name.dialog_uk_20 = "�� � ���� � ��������"
name.dialog_uk_21 = "�� � �����"
name.dialog_uk_22 = "�� � ����� ���������� ����������"
name.dialog_uk_23 = "�� � ���������"
name.dialog_uk_24 = "�� � ��������������� ������������"
name.dialog_uk_25 = "�� � ������"
name.dialog_uk_26 = "�� � ������������"
name.dialog_takelic = "������� ������������� �������������"
name.dialog_su = "����������� ������"
name.dialog_ticket = "�����"
name.dialog_cid = "����� ����"
name.dialog_settings = "��������� ��������"
name.dialog_mstroy = "���� �����"
name.dialog_mstroy_1 = "���� �����������"
name.dialog_mstroy_2 = "���� ����������"

local dialog = { }
dialog.main_1 = "��� � ������������� ������\n��� � ��������� ��������� � ������\n��� � ����� ��������� � ������"
dialog.main_2 = "��� � �������� ������\n��� � ������ �� ������ ��������� � ������� �� �����\n��� � �������� ������ � ����������� ����������\n��� � �������� ������ � �������\n��� � �������� ������ �� ������������� ��������\n��� � ������� � ������ ������������ ������������\n��� � �������� ������\n��� � ������ ������ ������\n��� � ������ ������ �����\n��� � ������ ������ �� �������\n��� � ������ ������� �� �������"
dialog.main_3 = "��� � ����� ������ � ������\n��� � ����� � ������ ��������� � ���������\n��� � ��������� ����� �������� ����������"
dialog.main_4 = "��� � ��������� ��������� � �������\n��� � ������ ������ ����� �������\n��� � ��������� ������������������� ������\n��� � ��������� ��������� ������������� ��������\n��� � ������� ����������� �������\n��� � ������� ��������� ����������\n��� � ������� �������� � �������������\n��� � ��������� ������������� � ��������\n��� � ������ ���������� ��������\n��� � ������ ��������� �/C\n��� � ��������� �/� �� ��"
--dialog.hide_chat = "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg
dialog.confirm = "�� �������, ��� ������ ������ �����?"
dialog.confirm_2 = "�� �������, ��� ������ ������� ������������ �������������?"
dialog.koap = "����� 1 � ��������� ����������� ������.\n����� 2 � ���� �� ��������� ������.\n����� 3 � ������ �������� ������� ���������.\n����� 4 � �������� � ������������ �����.\n����� 5 � �������� � ������������ �����, �������� �� �������� �� ����� ��������.\n����� 6 � ������������� ����� ����. ����� � ����������.\n����� 7 � ����������� ��������, ���������� ������������ ���������.\n����� 8 � ������������� �������, �����������.\n����� 9 � ����������� ��������.\n����� 10 � ��������������� ����.\n����� 11 � ���� � ��������� ����.\n����� 12 � ������ ������������ � ����.\n����� 13 � ���������.\n����� 14 � ����� �������������� ����������.\n��� � �������� ��������� ��������"
dialog.uk = "����� 1 � ���������\n����� 2 � ����������� ���������\n����� 3 � ��������\n����� 4 � ����\n����� 5 � ������\n����� 6 � ������\n����� 7 � ������ � ���������\n����� 8 � ������������\n����� 9 � �������������\n����� 10 � ������������� ��������\n����� 11 � ���������\n����� 12 � ��������� �� ������ ������\n����� 13 � �����������\n����� 14 � ���������� ������������ ���������\n����� 15 � �������\n����� 16 � �������� � ��������� ����\n����� 17 � ��������������\n����� 18 � ������\n����� 19 � ���� � ��������\n����� 20 � �����\n����� 21 � ����� ���������� ����������\n����� 22 � ���������\n����� 23 � ��������������� ������������\n����� 24 � ������\n����� 25 � ������������\n����� 26 � �� ���������"
dialog.koap_1 = "1.1. ��������� ����������� ������.\n1.2 ��������� ����������� ������, ���������� ���� ��������� ���."
dialog.koap_2 = "2.1. ���� �� ��������� ������.\n2.2. ���� �� ��������� ������, ���������� ���� ��������� ���."
dialog.koap_3 = "3.1. ������ �������� ������� ���������.\n3.2. ������ �������� ������� ���������, ���������� ���� ��������� ���."
dialog.koap_4 = "4.1. �������� ������������� �������� � ������������ �����."
dialog.koap_5 = "5.1. �������� ������������� �������� �� ��������, ������, ���������� �������� � ������ ������, ������������ ��� �������� ����.\n5.2. �������� �� �������� �� ����� ��������."
dialog.koap_6 = "6.1. ������������� ����� ����. �����.\n6.2. �� ������������� ����� ����. �����, ���������� ���� ��������� ���.\n6.3. �� ������������� ���������� ���������� ���."
dialog.koap_7 = "7.1. ����������� �������� ������������ ���������.\n7.2. �������� ��������� �������� �� ������ ��������.\n7.3. ���������� ������������ ��������� ��� ����������� �������� ����� ���.\n7.4. ���������� ������������ ��������� � ����������� ���������."
dialog.koap_8 = "8.1 ������������� ������������� �������.\n8.2. ����������� �������.\n8.3. ����������� ���������� ��� ����������."
dialog.koap_9 = "9.1. ����������� ��������, ������� ����� �������� � ���."
dialog.koap_10 = "10.1. ������������ �� ������������ �������� ��� ���������������� �����."
dialog.koap_11 = "11.1. ���� � ��������� ����.\n11.2. ���� � ��������� ���� ���������� ���� ��������� ���."
dialog.koap_12 = "12.1. ���� �� ������������ �������� ��� ����� ������������.\n12.2. ���� ��� ��������� ����� �� ��������������."
dialog.koap_13 = "13.1. ���� �� ������������ ��������, ������ �������� ����� ������� ���������������� ����� 70%."
dialog.koap_14 = "14.1. �����/��������� ���������� ������������ ���������� ������������������ ������� ������������� ��������.\n14.2. �����/��������� ���������� ������������ ���������� ������������������ ������� ���������� �� ���������."
dialog.uk_1 = "1.1. ��������� �� ����������� ����.\n1.2. ��������� �� ���������� ������������������ �������.\n1.3. ��������� �� ���������� ������� ����.\n1.4. ������������� ������ ����������."
dialog.uk_2 = "2.1. ���������� ��������� �� ����������� ����.\n2.2. ���������� ��������� �� ���������� ������������������ �������.\n2.3. ���������� ��������� �� ���� � ����� ����������� ���."
dialog.uk_3 = "3.1. �������� ������������ ����.\n3.2. �������� ���������� ������������������ �������."
dialog.uk_4 = "4.1. ������� ����� ���������������� ��� �������� ������������� ��������.\n4.2. ���� ���������������� ��� �������� ������������� ��������."
dialog.uk_5 = "5.1. ���� ��� ������� ���� ������ ������������ ����.\n5.2. ��������� ������ ����������� �����."
dialog.uk_6 = "6.1. ������� ������ � �������� ����.\n6.2. ������������� ������ ��� ��������.\n6.3. ����������� �������, ���������, ������� ������."
dialog.uk_7 = "7.1. ������ ������ ��� ������ ����������."
dialog.uk_8 = "8.1. ������������ ���������� ������������������ �������, ������������ ��� ����������.\n8.2. ������������ ���������� ������������������ ������� ��� ���������� �� � ������������� �������, � ��� �� ��� ���������� ����. ��������."
dialog.uk_9 = "9.1. ������������� �� ����������, ���������� ������������������� ��������.\n9.2. ������������� �� ������� ���������� ��� ���������� ���������.\n9.3. ������������� �� ���������� �������� ������� ����."
dialog.uk_10 = "10.1. �������� �/��� ��������� ������������� �������.\n10.2. ����, ���������������, ������������ ������������� �������.\n10.3 ������������ ������������� �������.\n10.4 ������������/������������/����������� ������������� �������.\n10.5. ��������/��������������� ����� ���������."
dialog.uk_11 = "11.1. ������������/���������� �������.\n11.2. �������� ������ ��������� � �������.\n11.3. ����������� ������ � ������� �� ��� ������ ���������� (����� ��������/���������)."
dialog.uk_12 = "12.1. ����� �� ������ ������."
dialog.uk_13 = "13.1. ����� ��������� ����������� ���, ��������������� �����������.\n13.2. �����/����������� �������������� ��������� (�������, �������, ���������)."
dialog.uk_14 = "14.1. ���������� ������������, �������."
dialog.uk_15 = "15.1. ������������/����������/��������� � ������������������� �������� ���� ������.\n15.2. ����������� �������, � ��� �� ������� � ������� �� ��������.\n15.3. ���� ����������� �����������, ������ ���������� ����������� �����������."
dialog.uk_16 = "16.1. ���������� ������������ ��������� � ��������� ������������ �/��� �������������� ���������."
dialog.uk_17 = "17.1. �������������� �������� �������, ������� �������������.\n17.2. �������������� �������� �������, ������� ������������� ����������� �����."
dialog.uk_18 = "18.1. ������ ���������� ������������������ �������."
dialog.uk_19 = "19.1. ���� � �������� ((� 2-4 ������� �������)), ����������� ��������� ���� ���������� � ������ �� 1 ���.\n19.2 ���� � �������� ((� 5-6 ������� �������)), ����������� ��������� ���� ���������� � ������ �� 2 ����."
dialog.uk_20 = "20.1. ����� �������� ���������.\n20.2. ����� ��������������� �������������, ������������� �����������, ���������, ����������."
dialog.uk_21 = "21.1. ����� ���������� �������."
dialog.uk_22 = "22.1. ��������� � ������������."
dialog.uk_23 = "23.1. �������/�������/���� ��������������� ����������.\n23.2. �������� ���������� ��������������� �������� �������������� �������������� ���������� �����������."
dialog.uk_24 = "24.1. ������� ���������� ��������� ����� �������������."
dialog.uk_25 = "25.1. ��������� �� �������� ������."
dialog.uk_26 = "26.1. �� ����� ���������� ����������� ����������� �����������, ������������� �������� � ����������� ������, ������ �� 6 ���."
dialog.takelic_1 = "������� �/� � ������� ������� ��������������\n������� �/� � ������������ ������� �� ���������� ������ "
dialog.takelic_2 = "������� ������� ������� �/�"
dialog.su_1 = "������ � ������� ������� ��������������\n������ � ������� �� ������ ��������� "
dialog.su_2 = "������� ������� �������"
dialog.su_3 = "������� ������� ���������� � ������"
dialog.ticket_1 = "����� � ������� ������� ��������������\n����� � ������� �� ������ ��������� "
dialog.ticket_2 = "������� ����� ������"
dialog.ticket_3 = "������� ������� ������ ������"
dialog.cid = "������� ID ������"
dialog.debug = ""
dialog.mstroy = "���� �����������\n���� ����������"
dialog.mstroy_1 = "������ 1\n������ 2\n ������ 3\n ������ 4\n���������� 1\n���������� 2"





function main() -- ����
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
				sampAddChatMessage(short_script_name.." ���� ��� ����� ������, "..first_color..""..users[i][4].."!", -1)
				sampAddChatMessage(short_script_name.." �� �������������� ���"..first_color.." "..users[i][5].."", -1)
				sampAddChatMessage(short_script_name.." ������ ��� �������� "..first_color.."��������� ������������", -1)
				sampAddChatMessage("", -1)
				messages.settings.debug = true
            end
        end
    end)
	
	sampAddChatMessage("", -1) -- �������������� ���������
	sampAddChatMessage("����� ����������, "..first_color..""..myNick.."!", -1)
	sampAddChatMessage(script_name..""..second_color.. " ��������!", -1)
	sampAddChatMessage("������� �� ������!", -1)
	sampAddChatMessage("", -1)
  while true do	
	wait(0)
	
	if messages.settings.debug and debug then 
		dialog.debug = "\n \n����� ��������������� ������������\t{00e600}�����������"
	end
	
	if msm then -- /msm
			sampAddChatMessage(service.." /setmark "..player_id, -1) -- debug
			sampSendChat("/setmark "..player_id)
			wait(1200)
		end
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_1) then -- ���� �� �������� �������� (�������� ����������) �� ALT + 1
		if mid == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ��� ������ ������ ��� ���������� ������� ������.", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function() 
				sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
				while sampIsDialogActive(33) do wait(100) end -- �������� �������� �������
				local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."��� ���������� ������.", -1)
							sampAddChatMessage("", -1)
							if messages.settings.name == "{f50029}�� �������" or messages.settings.deparament == "{f50029}�� �������" or messages.settings.rank == "{f50029}�� �������" then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� �� ��������� ������.", -1)
								sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/msettings ", -1)
								sampAddChatMessage("", -1)
							else
								sampShowDialog(2,"�������������� � "..player_name.." ["..mid.."]", dialog.main_1, button_yes, button_no, 2)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������ ������ ���.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������� ���������� "..first_color.."ID ������.", -1)
						sampAddChatMessage("", -1)
					end
			end)	
		else
			sampShowDialog(2,"�������������� � "..player_name.." ["..mid.."]", dialog.main_1, button_yes, button_no, 2)
		end
	end	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_2) then -- ���� �� �������� �������� (������� ������) �� ALT + 2
		if mid == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ��� ������ ������ ��� ���������� ������� ������.", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function() 
				sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
				while sampIsDialogActive(33) do wait(100) end -- �������� �������� �������
				local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."��� ���������� ������.", -1)
							sampAddChatMessage("", -1)
							if messages.settings.name == "{f50029}�� �������" or messages.settings.deparament == "{f50029}�� �������" or messages.settings.rank == "{f50029}�� �������" then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� �� ��������� ������.", -1)
								sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/msettings ", -1)
								sampAddChatMessage("", -1)
							else
								sampShowDialog(3,"�������������� � "..player_name.." ["..mid.."]", dialog.main_2, button_yes, button_no, 2)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������ ������ ���.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������� ���������� "..first_color.."ID ������.", -1)
						sampAddChatMessage("", -1)
					end
			end)	
		else
			sampShowDialog(3,"�������������� � "..player_name.." ["..mid.."]", dialog.main_2, button_yes, button_no, 2)
		end
	end	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_3) then -- ���� �� �������� �������� (��������� ������ � ��) �� ALT + 3
		if mid == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ��� ������ ������ ��� ���������� ������� ������.", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function() 
				sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
				while sampIsDialogActive(33) do wait(100) end -- �������� �������� �������
				local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."��� ���������� ������.", -1)
							sampAddChatMessage("", -1)
							if messages.settings.name == "{f50029}�� �������" or messages.settings.deparament == "{f50029}�� �������" or messages.settings.rank == "{f50029}�� �������" then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� �� ��������� ������.", -1)
								sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/msettings ", -1)
								sampAddChatMessage("", -1)
							else
								sampShowDialog(4,"�������������� � "..player_name.." ["..mid.."]", dialog.main_3, button_yes, button_no, 2)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������ ������ ���.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������� ���������� "..first_color.."ID ������.", -1)
						sampAddChatMessage("", -1)
					end
			end)	
		else
			sampShowDialog(4,"�������������� � "..player_name.." ["..mid.."]", dialog.main_3, button_yes, button_no, 2)
		end
	end	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_4) then -- ���� �� �������� �������� (��������� ���) �� ALT + 4
		if messages.settings.name == "{f50029}�� �������" or messages.settings.deparament == "{f50029}�� �������" or messages.settings.rank == "{f50029}�� �������" then
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �� ��������� ������.", -1)
				sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/msettings ", -1)
				sampAddChatMessage("", -1)
		else
			sampShowDialog(5, name.dialog_main_2, dialog.main_4, button_yes, button_no, 2)
		end
	end	
	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_5) then -- ���� �� �������� �������� (����� id)
		lua_thread.create(function() 
			sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
			while sampIsDialogActive(33) do wait(100) end -- �������� �������� �������
			local result, button, _, input = sampHasDialogRespond(33)
			if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
				if sampIsPlayerConnected(input) then
					mid = input
					player_id = mid
					player_name = sampGetPlayerNickname(player_id)
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� ������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."��� ���������� ������.", -1)
					sampAddChatMessage("", -1)
				else
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." ������ ������ ���.", -1)
					sampAddChatMessage("", -1)
				end
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������� ���������� "..first_color.."ID ������.", -1)
				sampAddChatMessage("", -1)
			end
		end)	
	end		
	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_6) then -- ���� �� �������� �������� (����� id)
		local get_player_id = getNearestID()
			if get_player_id then
				mid = get_player_id
				player_id = get_player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� ������� "..first_color.."���������� ������ "..second_color.."��� ���������� ������.", -1)
				sampAddChatMessage(short_script_name.." �� �������� "..first_color..""..player_name.." ["..player_id.."].", -1)
				sampAddChatMessage("", -1)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ����� ������ ��� :(", -1)
				sampAddChatMessage("", -1)
			end
	end	
	
	if isKeyDown(VK_MENU) and isKeyJustPressed(VK_9) then -- /c 60 �� ALT + 9
		lua_thread.create(function()
			sampSendChat("/me �������� �� ����")
			wait(777)
			sampSendChat("/c 60")
			wait(777)
			if os.date("%m") == "01" then      -- �������� �� ����� � ���� ������( ����� �������� ������� )
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "02" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "03" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ����� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "04" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "05" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ��� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "06" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "07" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ���� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "08" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "09" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." �������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "10" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "11" then
				if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������ "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			elseif os.date("%m") == "12" then
			if os.date("%A") == "Monday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				elseif os.date("%A") == "Tuesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Wednesday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����� � "..os.date("%X"))
				elseif os.date("%A") == "Thursday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Friday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Saturday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ������� � "..os.date("%X"))
				elseif os.date("%A") == "Sunday" then
					sampSendChat("/do �� ����� � "..os.date("%d").." ������� "..os.date("%Y").." � ����������� � "..os.date("%X"))
				end
			end
		end)
	end
	
	result, button, list, input = sampHasDialogRespond(2) -- �������������� � �������� ID 2
		if result then
			if button == 1 then
				if list == 0 then
					messages = inicfg.load(nil, directIni)
					lua_thread.create(function()
						sampSendChat("������� ������� �����!")
						wait(777)
						sampSendChat("��� ��������� ��������� "..messages.settings.deparament.." - "..messages.settings.rank.." "..messages.settings.name..".")
						wait(777)
						sampSendChat("/me ����� �����")
						wait(777)
						sampSendChat("/me ������ ������������� �� ���������� �������")
						wait(777)
						sampSendChat("/do ������������� � ����.")
						wait(777)
						sampSendChat("/me ��������� ������������� � ����������� ����")
						wait(777)
						sampSendChat("/anim 6 3 ")
						wait(777)
						sampSendChat("/doc "..mid)
					end)
				elseif list == 1 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						sampSendChat("������ ����� ������������ ���� ���������, � ������ ������� � ���.")
						wait(777)
						sampSendChat("� ����� ���������� ������ ������������ ��� ��������..")
						wait(777)
						sampSendChat("/n /pass "..myID.." - �������� �������.")
						wait(777)
						sampSendChat("/n /carpass "..myID.." - �������� ��������� �� ����������.")
						wait(777)
						sampSendChat("/n /rem - ��������� ������.")
						wait(777)
						sampSendChat("..��� ������� ��������, �� ����� �����������.")
					end)
				elseif list == 2 then
					lua_thread.create(function()
						sampSendChat("/me �������� ���� � ������ ��������� ���� ���� � "..player_name.. " ��������")
						wait(777)
						sampSendChat("/do �������� � �����.")
						wait(777)
						sampSendChat("/me ����������� ������� ������ � ���������")
						wait(777)
						sampSendChat("/do �������..")
						wait(777)
						sampSendChat("/me ������ �������� "..player_name)
					end)
				end
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(3) -- �������������� � �������� ID 3
		if result then
			if button == 1 then
				if list == 0 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..mid.."]"..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do ��������� � �������.")
						wait(777)
						sampSendChat("/me ������ ��������� �� �������.")
						wait(777)
						sampSendChat("/do ��������� � ����.")
						wait(777)
						sampSendChat("/me ������ ������ ����, ����� �������� ��� � ���� ������")
						wait(777)
						sampSendChat("/do �������..")
						wait(777)
						sampSendChat("/do ������� �������.")
						wait(777)
						sampSendChat("������ �� �����, ��� �� �� ����� ����..")
						wait(777)
						sampSendChat(rusnick("��-�, ����������, "..player_name..".."))
					end)
				elseif list == 1 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..mid.."]"..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do ��������� ����� �� �����.")
						wait(777)
						sampSendChat("/me ���� ��������� � �����")
						wait(777)
						sampSendChat("/do ��������� � ����.")
						wait(777)
						sampSendChat("/me ������ ��������� ���� ������� ���� ��������")
						wait(777)
						sampSendChat("/do ���� �������.")
						wait(777)
						sampSendChat("/todo ������� ��������� �� ��������*��� ������ ��������! ")
						wait(777)
						sampSendChat("/do ��������� ������.")
						wait(777)
						sampSendChat("/cuff "..mid)
						wait(777)
						sampSendChat("/me �������� ����� ������������ �� �����")
						wait(777)
						sampSendChat("/do �������..")
						wait(777)
						sampSendChat("/escort "..mid)
						ready_player1 = 1
					end)
				elseif list == 2 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."� ���������� ����������.", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/me ������ �������� ������ ���� ������, ������ ����� ����������")
						wait(777)
						sampSendChat("/do ����� ������������ ���������� �������.")
						wait(777)
						sampSendChat("/me ������� "..player_name.." � ����������")
						wait(777)
						sampSendChat("/do "..player_name.." ��������� � ����������� ����������.")
						wait(777)
						sampSendChat("/me ������ ��������� ���� ������ ����� ����������")
						wait(777)
						sampSendChat("/do  ����� ������������ ���������� �������.")
						wait(777)
						sampSendChat("/putpl "..mid)
					end)
				elseif list == 3 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� ���������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/me ������ ����� ������������ �������")
						wait(777)
						sampSendChat("/do ����� �������.")
						wait(777)
						sampSendChat("/me �������� "..player_name.." � ������")
						wait(777)
						sampSendChat("/do "..player_name.." ��� �����������.")
						wait(777)
						sampSendChat("/me ������ ��������� ���� ������ ����� �������")
						wait(777)
						sampSendChat("/do  ����� ������������ ������� �������.")
						wait(777)
						sampSendChat("/arrest "..mid)
					end)
				elseif list == 4 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."�� ����������.", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do ������ ���������� �����.")
						wait(777)
						sampSendChat("/ejectout "..mid)
						wait(777)
						sampSendChat("/todo ������ ������ �������� ������*��� �� �������� ���� ��������, �������!")
						wait(777)
						sampSendChat("/do ������ �������.")
						wait(777)
						sampSendChat("/me ������ ����� ����� ����� � ������� �������� �� ����������")
						wait(777)
						sampSendChat("/do ������� ����� �� �����.")
					end)
				elseif list == 5 then
				lua_thread.create(function()
					sampShowDialog(28, name.dialog_takelic, dialog.takelic_1, button_yes, button_no, 2)
					sampSendChat("/me ������ ��� �� �����")
					wait(777)
					sampSendChat("/me ������ ���� ���������")
					wait(777)
					sampSendChat("/me ��������� ���������� � ��������� � ����������")
					wait(777)
					sampSendChat("/do ������ ���������������.")
					wait(777)
					sampSendChat("/me ������ ������������ �������������")
					wait(777)
					sampSendChat("/do ������������ ������������� �������.")
					wait(777)
				end)
				elseif list == 6 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� ����������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color..".", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/do ������� ���������� ��� �� �����.")
						wait(777)
						sampSendChat("/me ������ ����� �� ����� � ������� ��� �������� ��������")
						wait(777)
						sampSendChat("����������� ������, ������ ����. ��� ������ ��������!")
						wait(777)
						sampSendChat("/me ����� �������� �� ����")
						wait(777)
						sampSendChat("/me ������ ����� ����� ����� � ������� �������� �� ����������")
						wait(777)
						sampSendChat("/me �������� ������ �� ������� ����� ����")
						wait(777)
						sampSendChat("/me �������� ������ �� ��������")
						wait(777)
						sampSendChat("/anim 5 1")
						wait(777)
						sampSendChat("/me �������� ������ �� ������ ����� ����")
						wait(777)
						sampSendChat("/do ����� ��������.")
						wait(777)
						sampSendChat("�������� ����� ������..")
						wait(777)
						sampSendChat("/search "..mid)
					end)
				elseif list == 7 then
					sampShowDialog(31, name.dialog_su, dialog.su_1, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me ������ ��� �� �����")
						wait(777)
						sampSendChat("/me �������� ��������� ��������������, ��������� ��� � ����")
						wait(777)
						sampSendChat("/do ������������� �������.")
						wait(777)
						sampSendChat("/me ��������� �������������� � ����������� ������")
					end)
				elseif list == 8 then
					tickets = 0
					reason1 = ""
					reason2 = ""
					reason3 = ""
					price = 0
					sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me ������ ��� �� �����")
						wait(777)
						sampSendChat("/me ������ ���� �������� ���������")
						wait(777)
						sampSendChat("/me ��������� �������� ���������")
						wait(777)
						sampSendChat("/todo ��������� �������� ���������*������ ��������� ��� ������ ��� �� ��. �����")
						wait(777)
						sampSendChat("��� ���������� �������� ����� � ������� ���� ����, ����� ���� ���������� ...")
						wait(777)
						sampSendChat(" ...���������� ���� ������������ �������������. ����� �������, �� ���������!")
					end)
				elseif list == 9 then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� ������ ������ �� ������� "..first_color..""..player_name.." ["..mid.."].", -1)
					sampAddChatMessage("", -1)
					sampSendChat("/pg "..mid, -1)
					sampAddChatMessage(service.." /pg "..mid, -1) -- Debug
					lua_thread.create(function()
						sampSendChat("/me ������ ����� �� �������")
						wait(777)
						sampSendChat("/do ����� � ����.")
						wait(777)
						sampSendChat("/me ������� ���������, ��� ����� ������ �� �����������")
					end)
				elseif list == 10 then	
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� ������ ������������ ������ "..first_color..""..player_name.." ["..mid.."].", -1)
					sampAddChatMessage(short_script_name.." ����� ��������� �������������, ����������� "..first_color.."/msm", -1)
					sampAddChatMessage("", -1)
					lua_thread.create(function()
						sampSendChat("/me ���� � ���� �������")
						wait(777)
						sampSendChat("/me ������� ��������� '����������� ������'")
						wait(777)
						sampSendChat("/do ��������.. ")
						wait(777)
						sampSendChat("/me ������� ������ �� ������ �������������")
						wait(777)
						sampSendChat("/do ������ ��������.")
						wait(1000)
						msm = not msm
					end)
				end
			end
		end		
		
		result, button, list, input = sampHasDialogRespond(4) -- �������������� � �������� ID 4
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function()
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." �� �������� ������ ������ "..first_color..""..player_name.." ["..mid.."].", -1)
						sampAddChatMessage("", -1)
						sampSendChat("/do "..player_name.." ��������� � ����������� �������.")
						wait(777)
						sampSendChat("/me ������ ��� �� ������� � ������� ���")
						wait(777)
						sampSendChat("/do ��� ����� � ������.")
						wait(777)
						sampSendChat("/me ����� � ���� ������ ��� � ����� ������� ��������")
						wait(777)
						sampSendChat("/me ������ ������� '����������� ������' � ������� ����")
						wait(777)
						sampSendChat("/do "..player_name.." �� ��������� � ����������� �������.")
						wait(777)
						sampSendChat("/clear "..mid)
					end)
				elseif list == 1 then
					lua_thread.create(function()
						sampSendChat("/me ������ ����� �� ���������� � ������� �� � ������")
						wait(777)
						sampSendChat("/do ��������� �������.")
						wait(777)
						sampSendChat("/me ���� �� � �������������� � ��������")
						wait(777)
						sampSendChat("/do ������� ��������.")
						wait(777)
						sampSendChat("/uncuff "..mid)
						wait(777)
						sampSendChat("/escort "..mid)
					end)
				elseif list == 2 then
					lua_thread.create(function()
						sampSendChat("/me ������ ��������� ���������� '"..rusnick(player_name).."'")
						wait(777)
						sampSendChat("�������, � ��� ��� ������.")
						wait(777)
						sampSendChat("������� �� �������������� ����������, ������ ���� ��������.")
					end)
				end
			end
		end	
		
		result, button, list, input = sampHasDialogRespond(5) -- �������������� � �������� ID 5
		if result then
			if button == 1 then
				if list == 0 then
					if isCharInAnyCar(PLAYER_PED) then
					lua_thread.create(function()
						sampSendChat("/me ���� ������� � ����, ����� ����� ������ '�'")
						wait(777)
						sampSendChat("/m ������� ��������� "..messages.settings.deparament.." - "..messages.settings.rank.." "..messages.settings.name..".")
						wait(777)
						sampSendChat("/m �������� �/� , ��������������� � ����������� � �������!")
						wait(777)
						sampSendChat("/m � ������ ������������ � ���� �������� ������� ����� �� ���������!")
						wait(777)
						sampSendChat("/me �������� ������ '�', ����� ����� �������")
					end)
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." �� �� ���������� �  "..first_color.."����������� ����!", -1)
						sampAddChatMessage("", -1)
					end
				elseif list == 1 then
					sampAddChatMessage(2)
				elseif list == 4 then
					lua_thread.create(function()
						sampSendChat("/do ����������� ������� ��������� � �������.")
						wait(777)
						sampSendChat("/me ������ ��������� ���� ������ ������� �� ������� � ������� ���")
						wait(777)
						sampSendChat("/todo ���� ������� ��������� ������*��-�, ��� �� ��� �����������..")
						wait(777)
						sampSendChat("/do ������ ��� ���������.")
						wait(777)
						sampSendChat("/police_tablet")
						wait(777)
						sampSendChat("/do ����������� ������� ����� � ������.")
					end)
				elseif list == 5 then
					lua_thread.create(function()
						sampSendChat("/do ����������� ������� ��������� � �������.")
						wait(777)
						sampSendChat("/me ������ ��������� ���� ������ ������� �� ������� � ������� ���")
						wait(777)
						sampSendChat("/todo ���� ������� ��������� ������ �����������*����� �� ������..")
						wait(777)
						sampSendChat("/do ������ ������������ ������� ���������.")
						wait(777)
						sampSendChat("/me ������ ���������� '����� �� ����������'")
						wait(777)
						sampSendChat("/do ��������� �������.")
						wait(777)
						sampSendChat("/me ������ ������ ��������� ������ �� ����������")
						wait(777)
						sampSendChat("/do ����������� �����.")
						wait(777)
						sampSendChat("/do �������..")
						wait(777)
						sampSendChat("/do ���������� �������..")
						wait(777)
						sampSendChat("/me ������� ��������� ����������")
						wait(777)
						sampSendChat("/do �������� ������������� ��������.")
					end)
				elseif list == 7 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						if os.date("%H") == "01" or os.date("%H") == "02" or os.date("%H") == "03" or os.date("%H") == "04" or os.date("%H") == "05" or os.date("%H") == "06" then 
							sampSendChat("������ ����, �. �������.")
						elseif os.date("%H") == "07" or os.date("%H") == "08" or os.date("%H") == "09" or os.date("%H") == "10" or os.date("%H") == "11" or os.date("%H") == "12" then 
							sampSendChat("������ ����, �. �������.")
						elseif os.date("%H") == "13" or os.date("%H") == "14" or os.date("%H") == "15" or os.date("%H") == "16" or os.date("%H") == "17" or os.date("%H") == "18" then 
							sampSendChat("������ ����, �. �������.")
						elseif os.date("%H") == "19" or os.date("%H") == "20" or os.date("%H") == "21" or os.date("%H") == "22" or os.date("%H") == "23" or os.date("%H") == "24" then 
							sampSendChat("������ �����, �. �������.")
						end
						wait(777)
						sampSendChat("� "..messages.settings.rank.." - "..messages.settings.name)
						wait(777)
						sampSendChat("��������� ������� ���� �������������?")
						wait(777)
						sampSendChat("/n /doc "..myID)
					end)
				elseif list == 8 then
				lua_thread.create(function() 
					sampShowDialog(33, name.dialog_cid, dialog.cid, button_yes, button_no, 1)
					while sampIsDialogActive(33) do wait(100) end -- �������� �������� �������
					local result, button, _, input = sampHasDialogRespond(33)
					if input:find("%d+") and not input:find("%W+") and not input:find("%p+") and not input:find("%s+") and not input:find("%a+") then
						if sampIsPlayerConnected(input) then
							mid = input
							player_id = mid
							player_name = sampGetPlayerNickname(player_id)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color..", ��� ��������.", -1)
							sampAddChatMessage("", -1)
							sampSendChat("/me ���� ������������� ��������")
							wait(777)
							sampSendChat("/do ������������� � ����.")
							wait(777)
							sampSendChat("/me ����������� � ��������������")
							wait(777)
							sampSendChat("/do ��������� "..rusnick(player_name).." -  ���������: �������")
							wait(777)
							sampSendChat("/me ������ �������� ��������")
							wait(777)
							sampSendChat("�������, �������, ��� ������..")
							wait(777)
							sampSendChat("/me ������ ����� � �����")
							wait(777)
							sampSendChat("/do ����� � ����� � ����.")
							wait(777)
							sampSendChat("/me ����� ��������� ������ � �����������")
							wait(777)
							sampSendChat("/do ������ ���������.")
							wait(777)
							sampSendChat("/todo ������� ������*���������, ��� �� �����?")
							wait(777)
							sampSendChat("/me ������� ����� �� ������������ ������������")
							wait(777)
							sampSendChat("/do ����� �������..")
							wait(777)
							sampSendChat("/setfree "..mid)
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������ ������ ���.", -1)
							sampAddChatMessage("", -1)
						end
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������� ���������� "..first_color.."ID ������.", -1)
						sampAddChatMessage("", -1)
					end
				end)
				elseif list == 9 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						sampSendChat("/me ������ ������� �� �������� � ������� ���")
						wait(777)
						sampSendChat("/do ������� ��� �������.")
						wait(777)
						sampSendChat("/me ����� � ������ '��������� �/�'")
						wait(777)
						sampSendChat("/me ����� ������ '����������' � ������������ ���������")
						wait(777)
						sampSendChat("/do �������� ��������� � ���� ���.")
						wait(777)
						sampSendChat("/me ����� ������� � ������")
						wait(777)
						sampSendChat("/do ��������� ����� ����������.")
						wait(777)
						sampSendChat("/me �������� ������� ���� ����������")
						wait(777)
						sampSendChat("/do ���� ������.")
						wait(777)
						sampSendChat("/me ��������� ������� �/� �� ����")
						wait(777)
						sampSendChat("/attach")
						wait(777)
						sampSendChat("/do ������������ �������� ���������.")
						wait(777)
						sampSendChat("/me ������ ���� ����������")
						wait(1000)
						sampSendChat("/do ���� ������.")
						wait(1000)
						sampSendChat("/me ����� ��������� �/�")
						wait(1000)
						sampSendChat("/me ������� ��������� � ������ ���������")
						wait(1000)
						sampSendChat("/r "..messages.settings.tag.." ����������� "..messages.settings.rank.." "..messages.settings.name.." | ������� ��������� ������������� �������� �� ��")
						wait(1000)
						sampSendChat("/c 60")
						wait(1000)
					end)
				elseif list == 10 then
					local myID = select(2, sampGetPlayerIdByCharHandle(1))
					lua_thread.create(function()
						sampSendChat("/do �� ������ ���������� ��������.")
						wait(777)
						sampSendChat("/me ���� ������ ����� ��������")
						wait(777)
						sampSendChat("/me ������� ���� �� ������� ������������� ��������")
						wait(777)
						sampSendChat("/do ���� ���������� ��������� �� ������������� ��������.")
						wait(777)
						sampSendChat("/me ������� ��������� � ����� ���������")
						wait(777)
						sampSendChat("/r "..messages.settings.tag.." ����������� "..messages.settings.rank.." "..messages.settings.name.." | ����������� ������������ �������� �� ��")
						wait(777)
						sampSendChat("/c 60")
					end)
				end
			end
		end		
		
	result, button, list, input = sampHasDialogRespond(6) -- �������������� � �������� ID 6
		if result then
			if button == 1 then
				if list == 0 then
					if messages.settings.chattc == true then
							messages.settings.chattc = false
							messages.settings.rchattc = "{f50029}���������"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������ "..first_color.."����� ��������������!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						elseif messages.settings.chattc == false then
							messages.settings.chattc = true
							messages.settings.rchattc = "{00e600}��������"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ����� ������ "..first_color.."����� ��������������!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						end
				elseif list == 1 then
					if messages.settings.chattrk == true then
							messages.settings.chattrk = false
							messages.settings.rchattrk = "{f50029}���������"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������ "..first_color.."����������� �� ���!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						elseif messages.settings.chattrk == false then
							messages.settings.chattrk = true
							messages.settings.rchattrk = "{00e600}��������"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ����� ������ "..first_color.."����������� �� ���!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
							end
						end
				elseif list == 2 then
					if messages.settings.chatadm == true then
						messages.settings.chatadm = false
						messages.settings.rchatadm = "{f50029}���������"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������ "..first_color.."��������� �� �������������!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					elseif messages.settings.chatadm == false then
						messages.settings.chatadm = true
						messages.settings.rchatadm = "{00e600}��������"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ����� ������ "..first_color.."��������� �� �������������!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					end
				elseif list == 3 then
					if messages.settings.chatorg == true then
						messages.settings.chatorg = false
						messages.settings.rchatorg = "{f50029}���������"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������ "..first_color.."����� �����������!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
						end
					elseif messages.settings.chatorg == false then
						messages.settings.chatorg = true
						messages.settings.rchatorg = "{00e600}��������"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ����� ������ "..first_color.."����� �����������!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
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
					sampAddChatMessage(short_script_name.." ��� ������ ��������.", -1)
					sampAddChatMessage("", -1)
				end
			end
		end			
		
	result, button, list, input = sampHasDialogRespond(11)
		
		if result then
			if button == 1 then
				if list == 0 then
					t_amount = 5000
					reason = "1.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				elseif list == 1 then
					t_amount = 10000
					reason = "1.2 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "2.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				elseif list == 1 then
					t_amount = 10000
					reason = "2.2 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
					cancellation_licence_last = 0
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "3.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 10000
					reason = "3.2 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "4.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "5.1 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 1000
					reason = "5.2 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "6.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 10000
					reason = "6.2 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 2 then
					t_amount = 15000
					reason = "6.3 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "7.1 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 4000
					reason = "7.2 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 2 then
					t_amount = 3000
					reason = "7.3 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 3 then
					t_amount = 3000
					reason = "7.4 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "8.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 3000
					reason = "8.2 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 2 then
					t_amount = 15000
					reason = "8.3 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "9.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "10.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "11.1 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 25000
					reason = "11.2 ����"
					cancellation_licence = 1
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "12.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 5000
					reason = "12.2 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "13.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					reason = "14.1 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				elseif list == 1 then
					t_amount = 15000
					reason = "14.2 ����"
					cancellation_licence = 0
					price = t_amount + price
					tickets = tickets + 1
				end
				if price > max_price_ticket or price < min_price_ticket then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color..""..max_price_ticket.." ���..", -1)
						sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
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
							sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
							sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
							sampAddChatMessage(" ", -1)
							tickets = tickets - 1
							price = price - t_amount
							sampShowDialog(25, name.dialog_double_koap, dialog.koap, button_yes, button_no, 2)
						else
							if cancellation_licence == 0 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
							elseif cancellation_licence == 1 then
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(short_script_name.." �� �������� � ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..third_color.. ""..t_amount.." ���. ", -1)
								sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage(" ", -1)
								sampAddChatMessage(notification.." �� ������ ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
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
					sampAddChatMessage(short_script_name.." ��������� �������� ���� ��������.", -1)
					sampAddChatMessage(short_script_name.." �������� �����: "..third_color..""..price.." ���. "..second_color.."���������� �����:"..first_color.." "..reason, -1)
					sampAddChatMessage("", -1)
				end
			else
				if price > max_price_ticket then
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." ������������ ����� ������ "..third_color""..max_price_ticket.." ���.", -1)
					sampAddChatMessage("", -1)
				else
					if tickets == max_tickets then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." �� ���� ��� ����������� ����� ������ ����� ������ � "..first_color..""..max_tickets_1..""..second_color.." ���������. ", -1)
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
						sampAddChatMessage(notification.." �� �������� ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
						sampAddChatMessage(" ", -1)
						sampShowDialog(29, name.dialog_confirm, dialog.confirm_2, button_confirm, button_no, 0)
					end
				elseif tickets == 2 then
					sampAddChatMessage(service.. " /ticket "..player_id.." "..price.." "..reason1.." + "..reason2, -1) 
					sampSendChat("/ticket "..player_id.." "..price.." "..reason1.." + "..reason2, -1) 
					wait(1800)
					if cancellation_licence == 1 then
						sampAddChatMessage(" ", -1)
						sampAddChatMessage(notification.." �� �������� ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
						sampAddChatMessage(" ", -1)
						sampShowDialog(29, name.dialog_confirm, dialog.confirm_2, button_confirm, button_no, 0)
					end
				elseif tickets == 3 then
					sampAddChatMessage(service.. " /ticket "..player_id.." "..price.." "..reason1.." + "..reason2.. " + "..reason3, -1) 
					sampSendChat("/ticket "..player_id.." "..price.." "..reason1.." + "..reason2.. " + "..reason3, -1) 
					wait(1800)
					if cancellation_licence == 1 then
						sampAddChatMessage(" ", -1)
						sampAddChatMessage(notification.." �� �������� ��������� ������������� "..first_color.."������� ������������� �������������!", -1)
						sampAddChatMessage(" ", -1)
						sampShowDialog(29, name.dialog_confirm, dialog.confirm_2, button_confirm, button_no, 0)
					end
				end
			end
		end	
		
		
		
	result, button, list, input = sampHasDialogRespond(28) -- �������������� � �������� ID 28
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function() 
						sampShowDialog(27, name.dialog_takelic, dialog.takelic_2, button_yes, button_no, 1)
						while sampIsDialogActive(27) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(27)
					if input:find("^%A+$") then
							reason_takelic = input
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ������ ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.." ������������� �������������. �������: "..first_color..""..input..".", -1)
							sampAddChatMessage("", -1)
							sampSendChat("/takelic "..mid.." "..input, -1)
							sampAddChatMessage(service.." /takelic "..mid.." "..input, -1) -- Debug
						else
							sampShowDialog(28, name.dialog_takelic, dialog.takelic_1, button_yes, button_no, 2)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ���������� ������� "..first_color.."������� �/�. "..second_color.."��������: "..first_color.."3.1 ����", -1)
							sampAddChatMessage("", -1)
						end
						end)
				elseif list == 1 then
					if reason_takelic == "�� �������" then
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." ������� �� ���� �������.", -1)
						sampAddChatMessage("", -1)
						sampShowDialog(28, name.dialog_takelic, dialog.takelic_1, button_yes, button_no, 2)
					else
						sampAddChatMessage("", -1)
						sampAddChatMessage(short_script_name.." �� ������ ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.." ������������� �������������. �������: "..first_color..""..reason_takelic..".", -1)
						sampAddChatMessage("", -1)
						sampSendChat("/takelic "..mid.." "..reason_takelic, -1)
						sampAddChatMessage(service.." /takelic "..mid.." "..reason_takelic, -1) -- Debug
						lua_thread.create(function()
							sampSendChat("/me ������ ��� �� �����")
							wait(777)
							sampSendChat("/me ������ ���� ���������")
							wait(777)
							sampSendChat("/me ��������� ���������� � ��������� � ����������")
							wait(777)
							sampSendChat("/do ������ ���������������.")
							wait(777)
							sampSendChat("/me ������ ������������ �������������")
							wait(777)
							sampSendChat("/do ������������ ������������� �������.")
						end)
					end	
				end
			end
		end	
	
	result, button, list, input = sampHasDialogRespond(31) -- �������������� � �������� ID 31
		if result then
			if button == 1 then
				if list == 0 then
						sampShowDialog(30, name.dialog_su, dialog.su_2, button_yes, button_no, 1)
						while sampIsDialogActive(30) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(30)
						if input:find("^%d+$") then
							if input == "1" or input == "2" or input == "3" or input == "4" or input == "5" or input == "6" then
								level = input
								sampShowDialog(32, name.dialog_su, dialog.su_3, button_yes, button_no, 1)
								while sampIsDialogActive(32) do wait(100) end -- �������� �������� �������
								local result, button, _, input = sampHasDialogRespond(32)
								reason = input
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..mid.."]"..second_color.." � ����������� ������.", -1)
								sampAddChatMessage(short_script_name.." ������� �������:"..first_color.." "..level..". "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage("", -1)
								sampSendChat("/su "..mid.." "..level.." "..reason, -1)
								sampAddChatMessage(service.." /su "..mid.." "..level.." "..reason, -1) -- Debug
							else
								sampShowDialog(31, name.dialog_su, dialog.su_1, button_yes, button_no, 2)
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." ������� ���������� ������� ������� "..first_color.."(�� 1 �� 6)", -1)
								sampAddChatMessage("", -1)
							end
						else
							sampShowDialog(31, name.dialog_su, dialog.su_1, button_yes, button_no, 2)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ���������� ������� ������� "..first_color.."(�� 1 �� 6)", -1)
							sampAddChatMessage("", -1)
						end
				elseif list == 1 then
					sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
				end
			end
		end		
		
	result, button, list, input = sampHasDialogRespond(35) -- �������������� � �������� ID 31
		if result then
			if button == 1 then
				if list == 0 then
						sampShowDialog(39, name.dialog_ticket, dialog.ticket_2, button_yes, button_no, 1)
						while sampIsDialogActive(39) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(39)
						if input:find("^%d+$") then
							if input > max_price_ticket or input < min_price_ticket then
								amount = input
								sampShowDialog(38, name.dialog_ticket, dialog.ticket_3, button_yes, button_no, 1)
								while sampIsDialogActive(38) do wait(100) end -- �������� �������� �������
								local result, button, _, input = sampHasDialogRespond(38)
								reason = input
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������ ������ "..first_color..""..player_name.." ["..mid.."]"..second_color.." �����.", -1)
								sampAddChatMessage(short_script_name.." �����:"..first_color.." "..amount..". "..second_color.."�������:"..first_color.." "..reason, -1)
								sampAddChatMessage("", -1)
								sampSendChat("/ticket "..mid.." "..amount.." "..reason, -1)
								sampAddChatMessage(service.." /ticket "..mid.." "..amount.." "..reason, -1) -- Debug
							else
								sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." ������� ���������� ����� ������ ( �� "..third_color..""..min_price_ticket.." ���. "..second_color.."�� "..third_color..""..max_price_ticket.." ���."..second_color.." )", -1)
								sampAddChatMessage("", -1)
							end
						else
							sampShowDialog(35, name.dialog_ticket, dialog.ticket_1, button_yes, button_no, 2)
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ���������� ����� ������ ( �� "..third_color..""..min_price_ticket.." ���. "..second_color.."�� "..third_color..""..max_price_ticket.." ���."..second_color.." )", -1)
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
				sampAddChatMessage(short_script_name.." �� ������ ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.." ������������� �������������. �������: "..first_color..""..reason_takelic..".", -1)
				sampAddChatMessage("", -1)
				sampSendChat("/takelic "..mid.." "..reason_takelic, -1)
				sampAddChatMessage(service.." /takelic "..mid.." "..reason_takelic, -1) -- Debug
				lua_thread.create(function()
					sampSendChat("/me ������ ��� �� �����")
					wait(777)
					sampSendChat("/me ������ ���� ���������")
					wait(777)
					sampSendChat("/me ��������� ���������� � ��������� � ����������")
					wait(777)
					sampSendChat("/do ������ ���������������.")
					wait(777)
					sampSendChat("/me ������ ������������ �������������")
					wait(777)
					sampSendChat("/do ������������ ������������� �������.")
				end)
			end
		end	
		
	result, button, list, input = sampHasDialogRespond(36)
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "������� �������� '��� �������'\n����������: ���������� ������� �������� �������\n��������: ������� �����", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+) (%W+)") and not input:find("%d+") and not input:find("%p+") then
							messages.settings.name = input
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������� �������� �������� "..first_color.. "��� ������� "..second_color.." �� "..first_color.. ""..input..".", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ��������. ��������: "..first_color.."������� �����.", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 1 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "������� �������� '������'\n����������: ���������� ������� �������� �������\n��������: �����", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+)") and not input:find("%d+") and not input:find("%p+") and not input:find("%s+") then
							messages.settings.rank = input
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������� �������� �������� "..first_color.. "������ "..second_color.." �� "..first_color.. ""..input..".", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ��������. ��������: "..first_color.."�����.", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 2 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "������� �������� '���'\n����������: ���������� ������� ��� ������, �������� �������\n��������: � (�����)", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+)") and not input:find("%d+") then
							messages.settings.tag = "["..input.."]"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������� �������� �������� "..first_color.. "��� "..second_color.." �� "..first_color.. "["..input.."].", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ��������. ��������: "..first_color.."� (�����).", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 3 then
					lua_thread.create(function() 
						sampShowDialog(37, dialog.name_settings, "������� �������� '�����������'\n����������: ���������� ������� �������� �������\n��������: ������������", button_yes, button_no, 1)
						while sampIsDialogActive(37) do wait(100) end -- �������� �������� �������
						local result, button, _, input = sampHasDialogRespond(37)
						if input:find("(%W+)") and not input:find("%d+") and not input:find("%p+") and not input:find("%s+") then
							messages.settings.deparament = input
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� ������� �������� �������� "..first_color.. "����������� "..second_color.." �� "..first_color.. ""..input..".", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
								messages = inicfg.load(nil, directIni)
							end
						else
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." ������� ��������. ��������: "..first_color.."���.", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end)
				elseif list == 4 then
					if messages.settings.rtag == false then
							messages.settings.rtag = true
							messages.settings.rrtag = "{00e600}��������"
							if inicfg.save(messages, directIni) then
								sampAddChatMessage("", -1)
								sampAddChatMessage(short_script_name.." �� �������� "..first_color.."�������������� ��������� ���� � �����!", -1)
								sampAddChatMessage("", -1)
								sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
							end
					elseif messages.settings.rtag == true then
						messages.settings.rtag = false
						messages.settings.rrtag = "{f50029}���������"
						if inicfg.save(messages, directIni) then
							sampAddChatMessage("", -1)
							sampAddChatMessage(short_script_name.." �� ��������� "..first_color.."�������������� ��������� ���� � �����!", -1)
							sampAddChatMessage("", -1)
							sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
						end
					end
				elseif list == 6 then
					sampShowDialog(41, name.dialog_settings,"��������\t��������\n���������� � �������������� � ���\t{00e600}" .. messages.settings.debug_adm, button_yes, button_no, 5)
				end
			end
		end
		
	result, button, list, input = sampHasDialogRespond(40)
		
		if result then
			if button == 1 then
				if list == 0 then
				sampSendChat("/su "..player_id.." 1 1.1 �� | ��������� �� ����������� ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 1.1 �� | ��������� �� ����������� ����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 1.2 �� | ��������� �� ���������� ������������������ �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 1.2 �� | ��������� �� ���������� ������������������ �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 6 1.3 �� | ��������� �� ���������� ������� ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 1.3 �� | ��������� �� ���������� ������� ����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 3 then
				sampSendChat("/su "..player_id.." 1 1.4 �� | ������������� ������ ����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 1.4 �� | ������������� ������ ����������.", -1)
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
				sampSendChat("/su "..player_id.." 3 2.1 �� | ���������� ��������� �� ����������� ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  3. "..second_color.."�������:"..first_color.." 2.1 �� | ���������� ��������� �� ����������� ����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 5 2.2 �� | ���������� ��������� �� ���������� ������������������ �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  5. "..second_color.."�������:"..first_color.." 2.2 �� | ���������� ��������� �� ���������� ������������������ �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 6 2.3 �� | ���������� ��������� �� ���� � ����� ����������� ���.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 2.3 �� | ���������� ��������� �� ���� � ����� ����������� ���.", -1)
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
				sampSendChat("/su "..player_id.." 5 3.1 �� | �������� ������������ ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  5. "..second_color.."�������:"..first_color.." 3.1 �� | �������� ������������ ����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 3.2 �� | �������� ���������� ������������������ �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 3.2 �� | �������� ���������� ������������������ �������.", -1)
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
				sampSendChat("/su "..player_id.." 1 4.1 �� | ������� ����� ���������������� ��� �������� �/c.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 4.1 �� | ������� ����� ���������������� ��� �������� �/c.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 3 4.2 �� | ���� ���������������� ��� �������� �/c.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  3. "..second_color.."�������:"..first_color.." 4.2 �� | ���� ���������������� ��� �������� �/c.", -1)
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
				sampSendChat("/su "..player_id.." 1 5.1 �� | ���� ��� ������� ���� ������ ������������ ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 5.1 �� | ���� ��� ������� ���� ������ ������������ ����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 5 5.2 �� | ��������� ������ ����������� �����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  5. "..second_color.."�������:"..first_color.." 5.2 �� | ��������� ������ ����������� �����.", -1)
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
				sampSendChat("/su "..player_id.." 1 6.1 �� | ������� ������ � �������� ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 6.1 �� | ������� ������ � �������� ����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 3 6.2 �� | ��������� ������ ����������� �����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  3. "..second_color.."�������:"..first_color.." 6.2 �� | ��������� ������ ����������� �����.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 5 6.3 �� | ����������� �������, ���������, ������� ������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  5. "..second_color.."�������:"..first_color.." 6.3 �� | ����������� �������, ���������, ������� ������.", -1)
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
				sampSendChat("/su "..player_id.." 6 7.1 �� | ������ ������ ��� ������ ����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 7.1 �� | ������ ������ ��� ������ ����������.", -1)
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
				sampSendChat("/su "..player_id.." 1 8.1 �� | ������������ ���������� ������������������ �������, ������������ ��� ����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 8.1 �� | ������������ ���������� ������������������ �������, ������������ ��� ����������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 2 8.2 �� | ������������ ���������� ������������������ ������� ��� ���������� �� � ������������� �������, � ��� �� ��� ���������� ����. ��������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 8.2 �� | ������������ ���������� ������������������ ������� ��� ���������� �� � ������������� �������, � ��� �� ��� ���������� ����. ��������.", -1)
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
				sampSendChat("/su "..player_id.." 2 9.1 �� | ������������� �� ����������, ���������� ������������������� ��������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 9.1 �� | ������������� �� ����������, ���������� ������������������� ��������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 1 9.2 �� | ������������� �� ������� ���������� ��� ���������� ���������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 9.2 �� | ������������� �� ������� ���������� ��� ���������� ���������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 4 9.3 �� | ������������� �� ���������� �������� ������� ����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 9.3 �� | ������������� �� ���������� �������� ������� ����.", -1)
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
				sampSendChat("/su "..player_id.." 4 10.1 �� | �������� �/��� ��������� ������������� �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 10.1 �� | �������� �/��� ��������� ������������� �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 10.2 �� | ����, ���������������, ������������ ������������� �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 10.2 �� | ����, ���������������, ������������ ������������� �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 3 10.3 �� | ������������ ������������� �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  3. "..second_color.."�������:"..first_color.." 10.3 �� | ������������ ������������� �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 3 then
				sampSendChat("/su "..player_id.." 6 10.4 �� | ������������/������������/����������� ������������� �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 10.4 �� | ������������/������������/����������� ������������� �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 4 then
				sampSendChat("/su "..player_id.." 1 10.5 �� | ��������/��������������� ����� ���������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 10.5 �� | ��������/��������������� ����� ���������.", -1)
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
				sampSendChat("/su "..player_id.." 6 11.1 �� | ������������/���������� �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 11.1 �� | ������������/���������� �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 1 11.2 �� | �������� ������ ��������� � �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 11.2 �� | �������� ������ ��������� � �������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 4 11.3 �� | ����������� ������ � ������� �� ��� ������ ����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 11.3 �� | ����������� ������ � ������� �� ��� ������ ���������� (����� ��������/���������).", -1)
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
				sampSendChat("/su "..player_id.." 2 12.1 �� | ����� �� ������ ������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 12.1 �� | ����� �� ������ ������.", -1)
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
				sampSendChat("/su "..player_id.." 1 13.1 �� | ����� ��������� ����������� ���, ��������������� �����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 13.1 �� | ����� ��������� ����������� ���, ��������������� �����������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 2 13.2 �� | �����/����������� �������������� ���������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 13.2 �� | �����/����������� �������������� ��������� (�������, �������, ���������).", -1)
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
				sampSendChat("/su "..player_id.." 3 14.1 �� | ���������� ������������, �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  3. "..second_color.."�������:"..first_color.." 14.1 �� | ���������� ������������, �������.", -1)
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
				sampSendChat("/su "..player_id.." 2 15.1 �� | ������������/����������/��������� � ������������������� �������� ���� ������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 15.1 �� | ������������/����������/��������� � ������������������� �������� ���� ������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 15.2 �� | ����������� �������, � ��� �� ������� � ������� �� ��������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 15.2 �� | ����������� �������, � ��� �� ������� � ������� �� ��������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 2 then
				sampSendChat("/su "..player_id.." 2 15.3 �� | ���� ����������� �����������, ������ ���������� ����������� �����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 15.3 �� | ���� ����������� �����������, ������ ���������� ����������� �����������.", -1)
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
				sampSendChat("/su "..player_id.." 1 16.1 �� | ���������� �/� � ��������� ������������ �/��� �������������� ���������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 16.1 �� | ���������� �/� � ��������� ������������ �/��� �������������� ���������.", -1)
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
				sampSendChat("/su "..player_id.." 2 17.1 �� | �������������� �������� �������, ������� �������������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 17.1 �� | �������������� �������� �������, ������� �������������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 17.2 �� | �������������� �������� �������, ������� ������������� ����������� �����.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 17.2 �� | �������������� �������� �������, ������� ������������� ����������� �����.", -1)
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
				sampSendChat("/su "..player_id.." 1 18.1 �� | ������ ���������� ������������������ �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 18.1 �� | ������ ���������� ������������������ �������.", -1)
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
				sampSendChat("/su "..player_id.." 1 19.1 �� | ���� � ��������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 19.1 �� | ���� � �������� ((� 2-4 ������� �������)), ����������� ��������� ���� ���������� � ������ �� 1 ���.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 19.2 �� | ���� � ��������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 19.2 �� | ���� � �������� ((� 5-6 ������� �������)), ����������� ��������� ���� ���������� � ������ �� 1 ���.", -1)
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
				sampSendChat("/su "..player_id.." 2 20.1 �� | ����� �������� ���������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  2. "..second_color.."�������:"..first_color.." 20.1 �� | ����� �������� ���������.", -1)
				sampAddChatMessage("", -1)
				elseif list == 1 then
				sampSendChat("/su "..player_id.." 4 20.2 �� | ����� ���. �������������, ������������� �����������, ���������, ����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 20.2 �� | ����� ���. �������������, ������������� �����������, ���������, ����������.", -1)
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
				sampSendChat("/su "..player_id.." 1 21.1 �� | ����� ���������� �������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  1. "..second_color.."�������:"..first_color.." 21.1 �� | ����� ���������� �������.", -1)
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
				sampSendChat("/su "..player_id.." 4 22.1 �� | ��������� � ������������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  4. "..second_color.."�������:"..first_color.." 22.1 �� | ��������� � ������������.", -1)
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
				sampSendChat("/su "..player_id.." 6 23.1 �� | �������/�������/���� ��������������� ����������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 23.1 �� | �������/�������/���� ��������������� ����������.", -1)
				sampAddChatMessage("", -1)
			elseif list == 1 then
				sampSendChat("/su "..player_id.." 6 23.2 �� | �������� ���. ���������� ���������� ������������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.."  6. "..second_color.."�������:"..first_color.." 23.2 �� | �������� ���. ���������� ���������� ������������.", -1)
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
				sampSendChat("/su "..player_id.." 1 24.1 �� | ������� ��������� ����� �������������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.." 1. "..second_color.."�������:"..first_color.." 24.1 �� | ������� ��������� ����� �������������.", -1)
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
				sampSendChat("/su "..player_id.." 2 25.1 �� | ��������� �� �������� ������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.." 2. "..second_color.."�������:"..first_color.." 25.1 �� | ��������� �� �������� ������.", -1)
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
				sampSendChat("/su "..player_id.." 6 26.1 �� | �� ���������.")
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."]"..second_color.." � ����������� ������.", -1)
				sampAddChatMessage(short_script_name.." ������� �������:"..first_color.." 6. "..second_color.."�������:"..first_color.." 26.1 �� | �� ���������.", -1)
				sampAddChatMessage("", -1)
				end
			else
				sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
			end
		end
		
	result, button, list, input = sampHasDialogRespond(67) -- �������������� � �������� ID 4
	
		if result then
			if button == 1 then
				if list == 0 then
					sampShowDialog(68, name.dialog_mstroy_1, dialog.mstroy_1, button_yes, button_no, 2)
				elseif list == 1 then
					sampShowDialog(69, name.dialog_mstroy_2, dialog.mstroy_2, button_yes, button_no, 2)
				end
			end
		end
	
	result, button, list, input = sampHasDialogRespond(68) -- �������������� � �������� ID 4
	
		if result then
			if button == 1 then
				if list == 0 then
					lua_thread.create(function()
						sampSendChat("/s ������ � �������� ��� ��� ����� �������� � ������� ��������� �� ���. ")
						wait(1000)
						sampSendChat("/s �������� - ��� �������� ��������, �� ����������� �������.")
						wait(1000)
						sampSendChat("/s �� �������� 4 ��������������� �����������: ���, ���, ��, ���-��.")
						wait(1000)
						sampSendChat("/s �� �������� ���������: ")
						wait(1000)
						sampSendChat("/s 1. ������������� � ����� �� ��������. ")
						wait(1000)
						sampSendChat("/s 2. ������������� � ����� � ������������ ��� ������� ����������. ")
						wait(1000)
						sampSendChat("/s 3. �������� ����� ��� ���������� ������������. ")
						wait(1000)
						sampSendChat("/s 4. ������� � ����� ��� ���������� ������������. ")
						wait(1000)
						sampSendChat("/s 5. ���������� �� ����� ��� ���������� ������������ ��� ��. �������. ")
						wait(1000)
						sampSendChat("/s 6. ������� ������ ����� �������� � �����������. ")
						wait(1000)
						sampSendChat("/s �� ���� ������ �� ���� '��������' ��������.")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 1 then
					lua_thread.create(function()
						sampSendChat("������� �����! ������ ����� ������! ���� ������: �������� ����������!")
						wait(1000)
						sampSendChat("��������� ��������� ����� �� ������ � � ������������ ������.")
						wait(1000)
						sampSendChat("������������� ��� ����� ��������� ��������� ��� ������� �� ��������� ������ �� ������")
						wait(1000)
						sampSendChat("������������� �� ����� ��������� ��������� � ����� �����.")
						wait(1000)
						sampSendChat("������������� ��� ����� ��������� ��������� �� ������ ��� � � ������������ ������.")
						wait(1000)
						sampSendChat("��� �������� ���������� �� ������� �������� ���������� ���������.")
						wait(1000)
						sampSendChat("���� � ��� ���� ��������� ��� �� � ������� �� �� ������� ���������� ������������")
						wait(1000)
						sampSendChat("� ����� ��������� ������������ ��� ���� �������.")
						wait(1000)
						sampSendChat("��� � �� ����� ��������� ��������� �� ��")
						wait(1000)
						sampSendChat("���� ���� ���������� ��� ���� � �����,")
						wait(1000)
						sampSendChat("� ��� �� ��� �������� �������� �� ����� ���.")
						wait(1000)
						sampSendChat("�� ���� ������ ��������. ������� ����?")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 2 then
					lua_thread.create(function()
						sampSendChat("/s ������ �� ���� �������������!")
						wait(1000)
						sampSendChat("������������ - ��� ��������� ���������, ����������� �� �������� �������������.")
						wait(1000)
						sampSendChat("��������� � �������� �� ������ ����������� ������ �� ������")
						wait(1000)
						sampSendChat("������: �. �������, �. ������� � �.�.")
						wait(1000)
						sampSendChat("��� �������������� ������ ���������� �����: ��� �����, ����.")
						wait(1000)
						sampSendChat("��������� �����: ��, ������, ����� � �.�.")
						wait(1000)
						sampSendChat("��� �������������� ������ ���������� �����: ����� ���.")
						wait(1000)
						sampSendChat("��������� �����: ���, �� ����, �� ���� � �.�.")
						wait(1000)
						sampSendChat("��� ����������� ���������� �����: ������� �����.")
						wait(1000)
						sampSendChat("��������� �����: ��, ������, ������� � �.�.")
						wait(1000)
						sampSendChat("��� ��������� ���������� �����: �������, ����������.")
						wait(1000)
						sampSendChat("��������� �����: ����, ��������, �������� � �.�.")
						wait(1000)
						sampSendChat("��� ��������� � �������� �� ������ ���������� �����: ��������� ����������?")
						wait(1000)
						sampSendChat("��� ������ ������� �������� � ��������� �����.")
						wait(1000)
						sampSendChat("�� ���� ������ ��������. ������� ����?")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 3 then
					lua_thread.create(function()
						sampSendChat("/s ������� �����! ������ ����� ������! ���� ������: ����!")
						wait(1000)
						sampSendChat("���������� ��������� ����� ������: ��� ��������, ��� � ���.")
						wait(1000)
						sampSendChat("��� ������������� �������� ����� '����' � '���'.")
						wait(1000)
						sampSendChat("��� ������������� ���, ��, �� ����� �� ������� � ������� � �����������.")
						wait(1000)
						sampSendChat("��� ������������� ���, ����, ��� ����� �� ��������, ������������ ������.")
						wait(1000)
						sampSendChat("� �������� ������ �� ������ ������������, ����� ��������.")
						wait(1000)
						sampSendChat("����������: � 00:00 �� 6:00.")
						wait(1000)
						sampSendChat("������� � ����� ������ ������� ������ 10 ����� � �������� � ����:")
						wait(1000)
						sampSendChat("1. ��������� ��� ����������. ��������� ����� ������.")
						wait(1000)
						sampSendChat("2. ���������. ����������, ��.")
						wait(1000)
						sampSendChat("�� ���� ������ ��������. ������� ����?")
						wait(1000)
						sampSendChat("/c 60")
					end)
				elseif list == 4 then
					lua_thread.create(function()
						sampSendChat("/s ������ ������� ����������!")
						wait(1234)
						sampSendChat("/c 60")
						sampSendChat("/n ��� ������������ � � ������ ��� ���������: ")
						wait(1234)
						sampSendChat("/n >> ������� 3 ��������� �� ������ ��������.")
						wait(1234)
						sampSendChat("/n >> �� �����, �� ������ ������.")
						wait(1234)
						sampSendChat("/n >> �� ����� �������: ����. ������ ���� :)")
						wait(1234)
						sampSendChat("/s ������ ����������: �������� ��� � ������")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s ������ ����������: �������� ���")
						wait(1000)
						sampSendChat("/n /anim 6 7 || /anim 6 21")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s �������, ���������. ��������� ����������: �������� ���")
						wait(1000)
						sampSendChat("/n ������� /anim 6 20")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s �����������! ������ ������ ����������")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s ����������! ���������.")
						wait(1000)
						sampSendChat("/n /anim 6 23")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s ���������! ��������� ��������� ��������� ���������")
						wait(1000)
						sampSendChat("/n /anim 8 2")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s ������ ������ � �����. ������!")
						wait(1234)
						sampSendChat("/c 60")
						wait(60000)
						sampSendChat("/s ������ ������� �����. ������� ������!")
						wait(1234)
						sampSendChat("/c 60")
						wait(90000)
						sampSendChat("/s ��������� ���������� ��� �� �����. ����� ������� ������!")
						wait(1234)
						sampSendChat("/c 60")
						wait(90000)
						sampSendChat("/s �� � ������� �����, �����. ���������� ��������.")
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
			sampAddChatMessage(short_script_name.." ����������� "..first_color.."/mid [ID ������].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				ready_player = 0
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� ������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."��� ���������� ������.", -1)
				sampAddChatMessage("", -1)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
 
 function cmd_msu(params) --/msu
    local id, level, reason = string.match(params, "(%d+) (%d+) (.+)")
		if id == nil or level == nil or reason == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.."/msu [ID ������] [������� ������� (� ������ ������� ����� �������)]", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(id) then
				player_id = id
				player_name = sampGetPlayerNickname(player_id)
				if level == "0" and reason == "0" then
					sampShowDialog(7, name.dialog_uk, dialog.uk, button_yes, button_no, 2)
					lua_thread.create(function()
						sampSendChat("/me ������ ��� �� �����")
						wait(777)
						sampSendChat("/me �������� ��������� ��������������, ��������� ��� � ����")
						wait(777)
						sampSendChat("/do ������������� �������.")
						wait(777)
						sampSendChat("/me ��������� �������������� � ����������� ������")
					end)
				else 
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..mid.."]"..second_color.." � ����������� ������.", -1)
					sampAddChatMessage(short_script_name.." ������� �������:"..first_color.." "..level..". "..second_color.."�������:"..first_color.." "..reason, -1)
					sampAddChatMessage("", -1)
					sampSendChat(string.format("/su %d %d %s", id, level, reason), -1)
					sampAddChatMessage(string.format(service.." /su %d %d %s", id, level, reason), -1) -- Debug
					lua_thread.create(function()
						sampSendChat("/me ������ ��� �� �����")
						wait(777)
						sampSendChat("/me �������� ��������� ��������������, ��������� ��� � ����")
						wait(777)
						sampSendChat("/do ������������� �������.")
						wait(777)
						sampSendChat("/me ��������� �������������� � ����������� ������")
					end)
				end
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end	
		end
	end

function cmd_mticket(params) --/mticket
    local id, amount, reason = string.match(params, "(%d+) (%d+) (.+)")
		if id == nil or amount == nil or reason == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.."/mticket [ID ������] [������� ������� (� ������ ������� ����� �������)]", -1)
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
						sampSendChat("/me ������ ��� �� �����")
						wait(777)
						sampSendChat("/me ������ ���� �������� ���������")
						wait(777)
						sampSendChat("/me ��������� �������� ���������")
						wait(777)
						sampSendChat("/todo ��������� �������� ���������*������ ��������� ��� ������ ��� �� ��. �����")
						wait(777)
						sampSendChat("��� ���������� �������� ����� � ������� ���� ����, ����� ���� ���������� ...")
						wait(777)
						sampSendChat(" ...���������� ���� ������������ �������������. ����� �������, �� ���������!")
					end)
				else
					sampAddChatMessage("", -1)
					sampAddChatMessage(short_script_name.." �� ������ ������ "..first_color..""..player_name.." ["..mid.."]"..second_color.." �����.", -1)
					sampAddChatMessage(short_script_name.." �����:"..first_color.." "..amount..". "..second_color.."�������:"..first_color.." "..reason, -1)
					sampAddChatMessage("", -1)
					sampSendChat(string.format("/ticket %d %d %s", id, amount, reason), -1)
					sampAddChatMessage(string.format(service.." /ticket %d %d %s", id, amount, reason), -1) -- Debug
					lua_thread.create(function()
						sampSendChat("/me ������ ��� �� �����")
						wait(777)
						sampSendChat("/me ������ ���� �������� ���������")
						wait(777)
						sampSendChat("/me ��������� �������� ���������")
						wait(777)
						sampSendChat("/todo ��������� �������� ���������*������ ��������� ��� ������ ��� �� ��. �����")
						wait(777)
						sampSendChat("��� ���������� �������� ����� � ������� ���� ����, ����� ���� ���������� ...")
						wait(777)
						sampSendChat(" ...���������� ���� ������������ �������������. ����� �������, �� ���������!")
					end)
				end
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end	
		end
	end

function cmd_msm(arg) -- /msm
	if #arg == 0 then
		if msm == true then
			msm = not msm
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �� ��������� ������������ ������ "..first_color..""..player_name.." ["..player_id.."].", -1)
			sampAddChatMessage("", -1)
		else
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.."/msm [ID ������]", -1)
			sampAddChatMessage("", -1)
		end
	else
		if sampIsPlayerConnected(arg) then
			player_id = arg
			player_name = sampGetPlayerNickname(player_id)
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �� ������ ������������ ������ "..first_color..""..player_name.." ["..player_id.."].", -1)
			sampAddChatMessage(short_script_name.." ����� ��������� �������������, ����������� "..first_color.."/msm", -1)
			sampAddChatMessage("", -1)
			lua_thread.create(function()
				sampSendChat("/me ���� � ���� �������")
				wait(777)
				sampSendChat("/me ������� ��������� '����������� ������'")
				wait(777)
				sampSendChat("/do ��������.. ")
				wait(777)
				sampSendChat("/me ������� ������ �� ������ �������������")
				wait(777)
				sampSendChat("/do ������ ��������.")
				wait(1000)
				msm = not msm
			end)
		else
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
			sampAddChatMessage("", -1)
		end
	end
end	 

function cmd_pg(arg) --/pg
	if sampIsPlayerConnected(id) then
		player_id = arg
		player_name = sampGetPlayerNickname(player_id)
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." �� ������ ������ �� ������� "..first_color..""..player_name.." ["..player_id.."].", -1)
		sampAddChatMessage("", -1)
		sampSendChat("/pg "..arg, -1)
		sampAddChatMessage("/pg "..arg, -1) -- Debug
		lua_thread.create(function()
			sampSendChat("/me ������ ����� �� �������.")
			wait(777)
			sampSendChat("/do ����� � ����.")
			wait(777)
			sampSendChat("/me ������� ���������, ��� ����� ������ �� �����������")
		end)
	else
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
		sampAddChatMessage("", -1)
	end	
end

function cmd_putpl(params) -- /putpl
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ����������� "..first_color.."/putpl [ID ������].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..player_id.."] "..second_color.."� ���������� ����������.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/me ������ �������� ������ ���� ������, ������ ����� ����������")
					wait(777)
					sampSendChat("/do ����� ������������ ���������� �������.")
					wait(777)
					sampSendChat("/me ������� "..player_name.." � ����������.")
					wait(777)
					sampSendChat("/do "..player_name.." ��������� � ����������� ����������.")
					wait(777)
					sampSendChat("/me ������ ��������� ���� ������ ����� ����������")
					wait(777)
					sampSendChat("/do  ����� ������������ ���������� �������.")
					wait(777)
					sampSendChat("/putpl "..mid)
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_arrest(params) -- /arrest
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ����������� "..first_color.."/arrest [ID ������].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� ���������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."� ���������� ����������.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/me ������ ����� ������������ �������")
					wait(777)
					sampSendChat("/do ����� �������.")
					wait(777)
					sampSendChat("/me �������� "..player_name.." � ������")
					wait(777)
					sampSendChat("/do "..player_name.." ��� �����������.")
					wait(777)
					sampSendChat("/me ������ ��������� ���� ������ ����� �������")
					wait(777)
					sampSendChat("/do  ����� ������������ ������� �������.")
					wait(777)
					sampSendChat("/arrest "..mid)
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_ejectout(params) -- /ejectout
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ����������� "..first_color.."/mejectout [ID ������].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage(short_script_name.." �� �������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color.."�� ����������.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/do ������ ���������� �����.")
					wait(777)
					sampSendChat("/ejectout "..mid)
					wait(777)
					sampSendChat("/todo ������ ������ �������� ������*��� �� �������� ���� ��������. �������!")
					wait(777)
					sampSendChat("/do ������ �������")
					wait(777)
					sampSendChat("/me ������ ����� ����� ����� � ������� �������� �� ����������")
					wait(777)
					sampSendChat("/do ������� ����� �� �����.")
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_search(params) -- /search
	local player_id = string.match(params, "(%d+)")
		if player_id == nil then 
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." ����������� "..first_color.."/msearch [ID ������].", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(player_id) then
				mid = player_id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� ����������� ������ "..first_color..""..player_name.." ["..mid.."] "..second_color..".", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/do ������� ���������� ��� �� �����")
					wait(777)
					sampSendChat("/me ������ ����� �� ����� � ������� ��� �������� ��������")
					wait(777)
					sampSendChat("����������� ������, ������ ����. ��� ������ ��������!")
					wait(777)
					sampSendChat("/me ����� �������� �� ����")
					wait(777)
					sampSendChat("/me ������ ����� ����� ����� � ������� �������� �� ����������")
					wait(777)
					sampSendChat("/me �������� ������ �� ������� ����� ����")
					wait(777)
					sampSendChat("/me �������� ������ �� ��������")
					wait(777)
					sampSendChat("/anim 5 1")
					wait(777)
					sampSendChat("/me �������� ������ �� ������ ����� ����")
					wait(777)
					sampSendChat("/do ����� ��������.")
					wait(777)
					sampSendChat("�������� ����� ������..")
					wait(777)
					sampSendChat("/search "..mid)
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end
		end
	end
	
function cmd_takelic(params) --/takelic
    local id, reason = string.match(params, "(%d+) (.+)")
		if id == nil or reason == "" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.."/mtakelic [ID ������] [�������]", -1)
			sampAddChatMessage("", -1)
		else
			if sampIsPlayerConnected(id) then
				player_id = id
				player_name = sampGetPlayerNickname(player_id)
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." �� ������ ������ "..first_color..""..player_name.." ["..player_id.."] "..second_color.." ������������� �������������.", -1)
				sampAddChatMessage("", -1)
				lua_thread.create(function()
					sampSendChat("/me ������ ��� �� �����")
					wait(777)
					sampSendChat("/me ������ ���� ���������")
					wait(777)
					sampSendChat("/me ��������� ���������� � ��������� � ����������")
					wait(777)
					sampSendChat("/do ������ ���������������.")
					wait(777)
					sampSendChat("/me ������ ������������ �������������")
					wait(777)
					sampSendChat("/do ������������ ������������� �������.")
					wait(777)
					sampSendChat(string.format("/takelic %d %s", id, reason), -1)
					sampAddChatMessage(string.format(service.." /takelic %d %s", id, reason), -1) -- Debug
				end)
			else
				sampAddChatMessage("", -1)
				sampAddChatMessage(short_script_name.." ������ ������ ���!", -1)
				sampAddChatMessage("", -1)
			end	
		end
	end

function cmd_hidechat() 
	sampShowDialog(6, name.dialog_hide_chat, "�������� ����\t��������\n��� ��������������\t" .. messages.settings.rchattc .. "\n����������� �� ���\t" .. messages.settings.rchattrk .. "\n��������� �� �������������\t" .. messages.settings.rchatadm .. "\n����� �����������\t" .. messages.settings.rchatorg.. ""..dialog.debug, button_yes, button_no, 5)
end

function cmd_settings()
	sampShowDialog(36, name.dialog_settings,"��������\t��������\n��� �������\t{00e600}" .. messages.settings.name .. "{ffffff}\n������\t{00e600}" .. messages.settings.rank .. "{ffffff}\n���\t{00e600}" .. messages.settings.tag .. "{ffffff}\n�����������\t{00e600}" .. messages.settings.deparament .. "{ffffff}\n�������������� ��� � �����\t{00e600}".. messages.settings.rrtag .. "" ..dialog.debug, button_yes, button_no, 5)
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
	sampAddChatMessage("[14:47:09] Timofey_Nahumovich[385] �������: ����. �������!",-1)
end

function cmd_mstroy()
	sampShowDialog(67, name.dialog_mstroy, dialog.mstroy, button_yes, button_no, 2)
end

-- ������ ����� ����
-- ID ��������
-- 2 - ���� �� �������� �������� (�������� ����������)
-- 3 - ���� �� �������� �������� (������� ������)
-- 4 - ���� �� �������� �������� (��������� ������ � ��)
-- 5 - ���� �� �������� �������� (��������� ���)
-- 6 - ������ ������� �����
-- 10 - ������ ����
-- 11-24 - ������ �����
-- 25 - ������ ��������� ������ ������ ����
-- 26 ����� ������ ������
-- 27 ���� ������� ������� ��
-- 30 ���� ������� �������
-- 31 ����� ������� �������
-- 32 level su
-- 33 �������� ID
-- 34 ���� id
-- 35
-- 36 ���� ��������
-- 37 �������� ��������
-- 38 ���� ticket
-- 39 ���� amount ticket
-- 40-66 su
-- 41 debug
-- 67 ���� �����
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
		if messages.settings.tag ~= "{f50029}�� �������" and #str >= 1 then
			sampSendChat(string.format("/r %s %s", messages.settings.tag, str))
		elseif messages.settings.tag == "{f50029}�� �������" then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �� �� ��������� ������.", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/msettings ", -1)
			sampAddChatMessage("", -1)
		elseif #str == 0 then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/r [���������] ", -1)
			sampAddChatMessage("", -1)
		end
	elseif messages.settings.rtag == false then
		if  #str >= 1 then
			sampSendChat(string.format("/r %s", str))
		elseif #str == 0 then
			sampAddChatMessage("", -1)
			sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/r [���������] ", -1)
			sampAddChatMessage(short_script_name.." � ��� ��������� ������� "..first_color.."��������������� ����� ���� � �����!", -1)
			sampAddChatMessage("", -1)
		end
	end
end

function cmd_d(params)


local id, text = string.match(params, "(%d+) (.+)")
	if id == nil or text == "" then
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." �����������: "..first_color.. "/d [ID �����������] [���������] ", -1)
		sampAddChatMessage("", -1)
		sampAddChatMessage(short_script_name.." ������ �����������: ", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."0"..second_color.." - "..first_color.."����� ����� ������������", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."1"..second_color.." - "..first_color.."�������������", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."2"..second_color.." - "..first_color.."������������ �������", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."3"..second_color.." - "..first_color.."������������ ���������������", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."4"..second_color.." - "..first_color.."��� '����'", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."5"..second_color.." - "..first_color.."������������ ������������ ��������", -1)
		sampAddChatMessage(short_script_name.." ID "..first_color.."6"..second_color.." - "..first_color.."����������� ������ ���������� ���������", -1)
		sampAddChatMessage("", -1)
	else
		if id == "0" then
			sampSendChat(string.format("/d [���] - [���] %s", text), -1)
		elseif id == "1" then 
			sampSendChat(string.format("/d [���] - [���-��] %s", text), -1)
		elseif id == "2" then 
			sampSendChat(string.format("/d [���] - [��] %s", text), -1)
		elseif id == "3" then 
			sampSendChat(string.format("/d [���] - [��] %s", text), -1)
		elseif id == "4" then 
			sampSendChat(string.format("/d [���] - [���] %s", text), -1)
		elseif id == "5" then 
			sampSendChat(string.format("/d [���] - [���] %s", text), -1)
		elseif id == "6" then 
			sampSendChat(string.format("/d [���] - [����] %s", text), -1)
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
		sampAddChatMessage("{33cc66}[R] ������� Arkady_Kotow[136]: [�] �����������: ����� | ���� �� ����� ��� | ���������: ����������.")
		sampSendChat("/c 60")
end
	

require('samp.events').onServerMessage = function(color, text)
	messages = inicfg.load(nil, directIni)
	if messages.settings.chattc == false then
		if text:match('[��������]') and text:match('������������') or text:match('[��������]') and text:match('�����������') or text:match('[��������]') and text:match('��������') then 
			return false
		end
	end
	if messages.settings.chatadm == false then
		if text:match('�������������') and text:match('�������:') then  
			return false
		end
	end
	if messages.settings.chattrk == false then
		if text:match('���������� �������� ��������� ���') then  
			return false
		end
		if text:match('��� ����') or text:match('��������') and text:match('�.') and text:match('') then  
			return false
		end
	end
	if messages.settings.chatorg == false then
		if text:match('[R]') and text:match('�������') or text:match('���������') or text:match('������������') or text:match('�����') or text:match('�������') or text:match('���������') or text:match('���������') or text:match('�������') or text:match('��������') or text:match('�������') then  
			return false
		end
	end
	if messages.settings.admnotif == true then
		if (text:find('�������������') and text:find(':') and text:find('���')) or text:find('%[A%]') then
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
			sampAddChatMessage("������� �����", -1)
		end
	end
end


function cmd_stroy(arg)
	lua_thread.create(function()
		sampSendChat("/r "..messages.settings.tag.. " ����� �� �����! ���������� - "..arg.. " ���. ���� ��� - �������!")
		wait(60000)
		arg1 = arg - 1
		if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " ����� ��������!")
		else
			sampSendChat("/r "..messages.settings.tag.. " ����� �� �����! ���������� - "..arg1.. " ���. ���� ��� - �������!")
			arg1 = arg - 2
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " ����� ��������!")
			else
			sampSendChat("/r "..messages.settings.tag.. " ����� �� �����! ���������� - "..arg1.. " ���. ���� ��� - �������!")
			arg1 = arg - 3
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " ����� ��������!")
			else
			sampSendChat("/r "..messages.settings.tag.. " ����� �� �����! ���������� - "..arg1.. " ���. ���� ��� - �������!")
			arg1 = arg - 4
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " ����� ��������!")
			else
			sampSendChat("/r "..messages.settings.tag.. " ����� �� �����! ���������� - "..arg1.. " ���. ���� ��� - �������!")
			arg1 = arg - 5
			wait(60000)
			if arg1 == 0 then
			sampSendChat("/r "..messages.settings.tag.. " ����� ��������!")
			else
			sampSendChat("/r "..messages.settings.tag.. " ����� �� �����! ���������� - "..arg1.. " ���. ���� ��� - �������!")
			end
			end
			end
			end
		end
	end)
end
