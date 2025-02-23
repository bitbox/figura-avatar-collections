-- Auto generated script file --

--hide vanilla armor model
vanilla_model.ARMOR:setVisible(false)

--hide vanilla cape model
vanilla_model.CAPE:setVisible(false)

--hide vanilla elytra model
vanilla_model.ELYTRA:setVisible(false)

vanilla_model.PLAYER:setVisible(false)

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()
  --player functions goes here
end

--tick event, called 20 times per second
function events.tick()
  --code goes here
end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
  if player:isCrouching() then
    models.model.root.Body.skrrrrt:rot(28,0,0)
    models.model.root.Body.skrrrrt:pos(0,2,0)
    models.model.root.LeftLeg:pos(0,2,-0.75)
    models.model.root.RightLeg:pos(0,2,-0.75)
  else
    models.model.root.Body.skrrrrt:rot(0,0,0)
    models.model.root.Body.skrrrrt:pos(0,0,0)
    models.model.root.LeftLeg:pos(0,0,0)
    models.model.root.RightLeg:pos(0,0,0)
  end
  --code goes here
end
