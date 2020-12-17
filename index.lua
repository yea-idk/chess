dofile('app0:/Vita3K.lua')
function endturn(a)
	if (a == 'r') then
		b = 'b'
	else
		b = 'r'
	end
	return b
end
white = Graphics.loadImage('app0:/image/whitepawn.png')
black = Graphics.loadImage('app0:/image/blackpawn.png')
board = Graphics.loadImage('app0:/image/board.png')
cursor = Graphics.loadImage('app0:/image/cursor.png')
tcursor = Graphics.loadImage('app0:/image/target.png')
oldpad = 'this was supposed to be chess'
tiles = {
	[1] = { 'e', 'r', 'e', 'r', 'e', 'r', 'e', 'r'},
	[2] = { 'r', 'e', 'r', 'e', 'r', 'e', 'r', 'e'},
	[3] = { 'e', 'r', 'e', 'r', 'e', 'r', 'e', 'r'},
	[4] = { 'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'},
	[5] = { 'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'},
	[6] = { 'b', 'e', 'b', 'e', 'b', 'e', 'b', 'e'},
	[7] = { 'e', 'b', 'e', 'b', 'e', 'b', 'e', 'b'},
	[8] = { 'b', 'e', 'b', 'e', 'b', 'e', 'b', 'e'},
}
cwhite = Color.new(255, 0, 0)
cblack = Color.new(0, 0, 0)
x = 1
y = 1
turn = 'r'
selected = 0
while true do
	Graphics.initBlend()
	Screen.clear()
	Graphics.drawImage(0, 0, board)
	if (turn == 'r') then
		Graphics.fillRect(544, 960, 0, 544, cwhite)
	else
		Graphics.fillRect(544, 960, 0, 544, cblack)
	end
	tmp0 = 0
	for i = 1, 8 do
		tmp0 = tmp0 + 1
		tmp1 = 0
		for j = 1, 8 do
			tmp1 = tmp1 + 1
			if (tiles[tmp0][tmp1] == 'r') then
				Graphics.drawImage((tmp1 - 1) * 68, (tmp0 - 1) * 68, white)
			elseif (tiles[tmp0][tmp1] == 'b') then
				Graphics.drawImage((tmp1 - 1) * 68, (tmp0 - 1) * 68, black)
			end
		end
	end
	if (selected == 1) then
		tmp0 = 0
		for i = 1, 8 do
			tmp0 = tmp0 + 1
			tmp1 = 0
			for j = 1, 8 do
				tmp1 = tmp1 + 1
				if (tiles1[tmp0][tmp1] == 1) then
					Graphics.drawImage((tmp1 - 1) * 68, (tmp0 - 1) * 68, tcursor)
				end
			end
		end
	end
	Graphics.drawImage((x - 1) * 68, (y - 1) * 68, cursor)
	pad = Controls.read()
	if (Controls.check(pad, SCE_CTRL_LEFT)) and not (Controls.check(oldpad, SCE_CTRL_LEFT)) then
		x = x - 1
	elseif (Controls.check(pad, SCE_CTRL_RIGHT)) and not (Controls.check(oldpad, SCE_CTRL_RIGHT)) then
		x = x + 1
	elseif (Controls.check(pad, SCE_CTRL_UP)) and not (Controls.check(oldpad, SCE_CTRL_UP)) then
		y = y - 1
	elseif (Controls.check(pad, SCE_CTRL_DOWN)) and not (Controls.check(oldpad, SCE_CTRL_DOWN)) then
		y = y + 1
	elseif (Controls.check(pad, SCE_CTRL_SQUARE)) and not (Controls.check(oldpad, SCE_CTRL_SQUARE)) then
		turn = endturn(turn)
	elseif (Controls.check(pad, SCE_CTRL_CIRCLE)) and not (Controls.check(oldpad, SCE_CTRL_CIRCLE)) then
		if (tiles[y][x] == turn) and (selected == 0) then
			x1 = x
			y1 = y
			selected = 1
			tiles1 = {
				[1] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[2] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[3] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[4] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[5] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[6] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[7] = { 0, 0, 0, 0, 0, 0, 0, 0},
				[8] = { 0, 0, 0, 0, 0, 0, 0, 0},
			}
			if (turn == 'r') then
				dir = 1
				target = 'b'
			else
				dir = -1
				target = 'r'
			end
			tiles1[y1][x1] = 1
			if (y1 + dir > 0) and (y1 + dir < 9) and (x1 + 1 > 0) and (x1 + 1 < 9) and (tiles[y1 + dir][x1 + 1] == 'e') then
				tiles1[y1 + dir][x1 + 1] = 1
			end
			if (y1 + dir > 0) and (y1 + dir < 9) and (x1 - 1 > 0) and (x1 - 1 < 9) and (tiles[y1 + dir][x1 - 1] == 'e') then
				tiles1[y1 + dir][x1 - 1] = 1
			end
			if (y1 + (dir * 2) > 0) and (y1 + (dir * 2) < 9) and (x1 + 2 > 0) and (x1 + 2 < 9) and (tiles[y1 + dir][x1 + 1] == target) and (tiles[y1 + (dir * 2)][x1 + 2] == 'e') then
				tiles1[y1 + (dir * 2)][x1 + 2] = 1
			end
			if (y1 + (dir * 2) > 0) and (y1 + (dir * 2) < 9) and (x1 - 2 > 0) and (x1 - 2 < 9) and (tiles[y1 + dir][x1 - 1] == target) and (tiles[y1 + (dir * 2)][x1 - 2] == 'e') then
				tiles1[y1 + (dir * 2)][x1 - 2] = 1
			end
		elseif (selected == 1) then
			if (x == x1) and (y == y1) then
				selected = 0
			end
			if (selected == 1) then
				if (tiles1[y][x] == 1) then
					tiles[y1][x1] = 'e'
					tiles[y][x] = turn
					if (x > x1) then
						tiles[y - dir][x1 + 1] = 'e'
					elseif (x < x1) then
						tiles[y - dir][x1 - 1] = 'e'
					end
					selected = 0
					turn = endturn(turn)
				end
			end
		end
	elseif (Controls.check(pad, SCE_CTRL_CROSS)) and not (Controls.check(oldpad, SCE_CTRL_CROSS)) then
		System.exit()
	end
	if (y < 1) then
		y = 1
	elseif (y > 8) then
		y = 8
	end
	if (x < 1) then
		x = 1
	elseif (x > 8) then
		x = 8
	end
	oldpad = pad
	Graphics.termBlend()
	Screen.flip()
	Screen.waitVblankStart()
end