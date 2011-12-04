guy_img = love.graphics.newImage("assets/char.png")
bullet_img = love.graphics.newImage("assets/bullet.png")
gun_img = love.graphics.newImage("assets/gun.png")
bg_img = love.graphics.newImage("assets/bg.jpg")
guy2_img = love.graphics.newImage("assets/char2.png")
gun2_img = love.graphics.newImage("assets/gun2.png")
music = love.audio.newSource("assets/song.mp3")
love.audio.play(music)
music:setLooping(true)

bullets = {}
move_x = 0
move_y = 0
guy = {}
guy.x = 382
guy.y = 400

function love.draw()
  love.graphics.draw(bg_img,0,0)
  x, y = love.mouse.getPosition()
  local gun_dir = math.atan2(x - guy.x, guy.y - y)
  if gun_dir > 0 and gun_dir < math.pi then
    love.graphics.draw(guy2_img, guy.x , guy.y, 0, 1,1,32,64)
    love.graphics.draw(gun2_img, guy.x, guy.y, gun_dir, 1, 1, 6, 90 )
  else
    love.graphics.draw(guy_img, guy.x , guy.y, 0, 1,1,32,64)
    love.graphics.draw(gun_img, guy.x, guy.y, gun_dir, 1, 1, 20, 90 )
  end
  love.graphics.print("This is x and y: " ..x .." "..y , 0,0)
  for i,v in ipairs(bullets) do
    love.graphics.draw(bullet_img, v.x, v.y, v.dir + math.pi/2)
  end
end

mainshoot_dt = 0

function love.update(dt)
  mainshoot_dt = mainshoot_dt + dt
  if mainshoot_dt > .18 and mainshoot then
    mainshoot_dt = 0
    fireBullets()  
  end
  for i,v in ipairs(bullets) do
    v.x = v.x + math.cos(v.dir) * dt * 300
    v.y = v.y + math.sin(v.dir) * dt * 300
  end
  local move_x = 0
  local move_y = 0
  if (love.keyboard.isDown("w")) then
    move_y = move_y - 100
  end
  if (love.keyboard.isDown("a")) then
    move_x = move_x - 100
  end
  if (love.keyboard.isDown("s")) then
    move_y = move_y + 100
  end
  if (love.keyboard.isDown("d")) then
    move_x = move_x + 100
  end
  guy.x = guy.x + move_x * dt
  guy.y = guy.y + move_y * dt
  
  for i,v in ipairs(bullets) do
    if (v.x > 800 or v.y > 600) or (v.x < 0 or v.y < 0) then
        table.remove(bullets,i)
      end
  end
end

mainshoot = false

function love.mousepressed(x, y, button)
  if button == "l" then
    mainshoot = true
  end
end

function love.mousereleased(x, y, button)
  if button == "l" then
    mainshoot = false
  end
end

function fireBullets()
  local x = love.mouse.getX()
  local y = love.mouse.getY()
  local dir = math.atan2(x - guy.x, guy.y - y )-math.pi/2
  local bullet = {}
  bullet.x = guy.x + (math.cos(dir)) * 90
  bullet.y = guy.y + (math.sin(dir)) * 90
  bullet.dir = dir
  table.insert(bullets, bullet)
  
end
