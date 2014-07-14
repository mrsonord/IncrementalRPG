"use strict"

define (require) ->
  $ = require("jquery")
  units = require("./units")
  bootstrap = require("bootstrap")



#TODO - Fix costs on sharpen upgrades
#TODO - Miners mine ore past capacity
$ = jQuery

# Variables
names =
  realm: ""
  king: ""

self =
  increment: 1
  upgrade:
    wood: 100
    stone: 100
    food: 100
    silver: 0
    gold: 0
wood =
  amount: 0
  increment: 0
  max: 100

stone =
  amount: 0
  increment: 0
  max: 100

food =
  amount: 0
  increment: 0
  max: 100

ore =
  increment: 0
  amount: 0
  max: 200
  iron:
    amount: 0
  copper:
    amount: 0
  silver:
    amount: 0
  gold:
    amount: 0

tent =
  amount: 0
  residents: 1
  health: 200
  cost:
    wood: 30
  upCost:
    wood: 70
    silver: 50
    gold: 25

house =
  amount: 0
  residents: 4
  health: 500
  cost:
    wood: 75
    stone: 25
  upCost:
    wood: 100
    stone: 100
    silver: 60
    gold: 30

hostel =
  amount: 0
  residents: 10
  health: 1200
  cost:
    wood: 200
    stone: 215
    iron: 25

mine =
  amount: 0
  health: 500
  cost:
    wood: 100
    stone: 100
    iron: 25

quarry =
  amount: 0
  health: 500
  cost:
    wood: 100
    stone: 100

silo =
  amount: 0
  health: 500
  cost:
    wood: 100
    stone: 100

mill =
  amount: 0
  health: 500
  cost:
    wood: 100
    stone: 100

carpentry =
  cost:
    silver: 50
    gold: 25
masonry =
  cost:
    silver: 50
    gold: 25
maxPop = (tent.residents * tent.amount) + (house.residents * house.amount)
nIntervId = undefined
bunkBeds = $('#upgradeBunkBeds')
bldTent = $('#buildTent')
bldHouse = $('#buildHouse')
sleepingBags = $('#upgradeSleepingBags')
bldMine = $('#buildMine')
bldMill = $('#buildMill')
bldSilo = $('#buildSilo')
bldQuarry = $('#buildQuarry')
hagStone = $('#upgradeMasonry')
stoneInc = $('#upgradeStrengthenShovels')
hagWood = $('#upgradeCarpentry')
foodInc = $('#upgradeSharpenArrows')
upSelf = $('#upgradeSelf')
oreInc = $('#upgradeSharpenPicks')
upMasonry = $('#upgradeMasonry')
hagWood = $('#upgradeCarpentry')
logInc = $('#upgradeSharpenAxes')

# Test max resources
checkMaxwood = ->
  wood.amount = wood.max if wood.amount >= wood.max
  return
checkMaxStone = ->
  stone.amount = stone.max if stone.amount >= stone.max
  return
checkMaxFood = ->
  food.amount = food.max if food.amount >= food.max
  return
checkMaxOre = ->
  oreTotal = ore.iron.amount + ore.copper.amount + ore.silver.amount + ore.gold.amount
  ore.amount = ore.max if oreTotal >= ore.max
  return

# Display the correct values.
updateValues = ->
  ore.increment = (miner.increment * miner.amount)
  wood.increment = (logger.increment * logger.amount)
  stone.increment = (mason.increment * mason.amount)
  food.increment = (hunter.increment * hunter.amount)
  checkMaxOre()
  ore.amount = ore.iron.amount + ore.copper.amount + ore.silver.amount + ore.gold.amount
  document.getElementById("maxPop").innerHTML = maxPop
  document.getElementById("tentAmount").innerHTML = tent.amount
  #document.getElementById("tentCostwood").innerHTML = tent.cost.wood
  document.getElementById("tentResidents").innerHTML = tent.residents
  document.getElementById("houseAmount").innerHTML = house.amount
  document.getElementById("houseResidents").innerHTML = house.residents
  #document.getElementById("hostelAmount").innerHTML = hostel.amount
  #document.getElementById("hostelCostwood").innerHTML = hostel.cost.wood
  #document.getElementById("hostelCostStone").innerHTML = hostel.cost.stone
  #document.getElementById("hostelResidents").innerHTML = hostel.residents
  document.getElementById("millAmount").innerHTML = mill.amount
  #document.getElementById("millCostwood").innerHTML = mill.cost.wood
  #document.getElementById("millCostStone").innerHTML = mill.cost.stone
  #document.getElementById("millCostIron").innerHTML = mill.cost.iron
  document.getElementById("quarryAmount").innerHTML = quarry.amount
  #document.getElementById("quarryCostwood").innerHTML = quarry.cost.wood
  #document.getElementById("quarryCostStone").innerHTML = quarry.cost.stone
  #document.getElementById("quarryCostIron").innerHTML = quarry.cost.iron
  document.getElementById("siloAmount").innerHTML = silo.amount
  #document.getElementById("siloCostwood").innerHTML = silo.cost.wood
  #document.getElementById("siloCostStone").innerHTML = silo.cost.stone
  document.getElementById("mineAmount").innerHTML = mine.amount
  #document.getElementById("mineCostwood").innerHTML = mine.cost.wood
  #document.getElementById("mineCostStone").innerHTML = mine.cost.stone
  #document.getElementById("mineCostIron").innerHTML = mine.cost.iron
  document.getElementById("maxOre").innerHTML = ore.max
  document.getElementById("ironAmount").innerHTML = ore.iron.amount
  document.getElementById("copperAmount").innerHTML = ore.copper.amount
  document.getElementById("silverAmount").innerHTML = ore.silver.amount
  document.getElementById("goldAmount").innerHTML = ore.gold.amount
  document.getElementById("oreAmount").innerHTML = ore.amount
  document.getElementById("maxWood").innerHTML = wood.max
  document.getElementById("woodAmount").innerHTML = wood.amount
  document.getElementById("stoneAmount").innerHTML = stone.amount
  document.getElementById("foodAmount").innerHTML = food.amount
  document.getElementById("woodIncrement").innerHTML = wood.increment
  document.getElementById("maxStone").innerHTML = stone.max
  document.getElementById("stoneIncrement").innerHTML = stone.increment
  document.getElementById("maxFood").innerHTML = food.max
  document.getElementById("foodIncrement").innerHTML = food.increment
  document.getElementById("workerAmount").innerHTML = worker.amount
  document.getElementById("loggerAmount").innerHTML = logger.amount
  document.getElementById("masonAmount").innerHTML = mason.amount
  document.getElementById("minerAmount").innerHTML = miner.amount
  document.getElementById("hunterAmount").innerHTML = hunter.amount
  document.getElementById("loggerCost").innerHTML = logger.cost
  document.getElementById("minerCost").innerHTML = miner.cost
  document.getElementById("hunterCost").innerHTML = hunter.cost
  document.getElementById("masonCost").innerHTML = mason.cost
  document.getElementById("upgradeSelfTotal").innerHTML = self.increment
  document.getElementById("oreIncrement").innerHTML = ore.increment
  return


# Loggers Gather wood
gatherWood = ->
  wood.amount += wood.increment
  checkMaxwood()
  updateValues()
  return

# Quarriers Gather Stone
gatherStone = ->
  stone.amount += stone.increment
  checkMaxStone()
  updateValues()
  return

# Hunters Gather Food
gatherFood = ->
  food.amount += food.increment
  checkMaxFood()
  updateValues()
  return

# Miners Gather Ore
gatherOre = ->
  unless ore.amount >= ore.max
    ores = [
      "c"
      "c"
      "c"
      "i"
      "i"
      "i"
      "i"
      "s"
      "s"
      "g"
    ]
    miners = miner.amount
    oreChoice = ores[Math.floor(Math.random() * ores.length)]
    if oreChoice is "i"
      ore.iron.amount += ore.increment
      ore.amount += ore.increment
    else if oreChoice is "c"
      ore.copper.amount += ore.increment
      ore.amount += ore.increment
    else if oreChoice is "s"
      ore.silver.amount += ore.increment
      ore.amount += ore.increment
    else
      ore.gold.amount += ore.increment
      ore.amount += ore.increment
    checkMaxOre()
    updateValues()
  return


$(document).ready ->
  beginTick = ->
    nIntervId = setInterval(tick, 5000)
    return
  tick = ->
    gatherWood()
    gatherStone()
    gatherFood()
    gatherOre()
    return
  #$("#onLoadModal").modal()
  beginTick()
  updateValues()
  ###$("#modalClose").click ->
    names.realm = document.getElementById("realm").value
    document.getElementById("realmName").innerHTML = names.realm
    names.king = document.getElementById("king").value
    document.getElementById("kingName").innerHTML = names.king
    return###
  return

titleCase = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

$('#chopWood').click ->
  wood.amount += self.increment
  checkMaxwood()
  updateValues()
  return

$('#mineStone').click ->
  stone.amount += self.increment
  checkMaxStone()
  updateValues()
  return

$('#gatherFood').click ->
  food.amount += self.increment
  checkMaxFood()
  updateValues()
  return

$('#mineOre').click ->
  unless ore.amount >= ore.max
    ores = [
      "c"
      "c"
      "c"
      "i"
      "i"
      "i"
      "i"
      "s"
      "s"
      "g"
    ]
    oreChoice = ores[Math.floor(Math.random() * ores.length)]
    if oreChoice is "i"
      ore.iron.amount += self.increment
      ore.amount += self.increment
    else if oreChoice is "c"
      ore.copper.amount += self.increment
      ore.amount += self.increment
    else if oreChoice is "s"
      ore.silver.amount += self.increment
      ore.amount += self.increment
    else
      ore.gold.amount += self.increment
      ore.amount += self.increment
    checkMaxOre()
    updateValues()
    return

$('#hireLogger').click ->
  if worker.amount < maxPop
    if food.amount >= logger.cost
      food.amount -= logger.cost
      worker.amount++
      logger.amount++
      logger.cost++
      updateValues()
    else $('#info').prepend $("<p>You need more food.</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need to build more accommodation.</p>").fadeIn("slow")

$('#hireMiner').click ->
  if worker.amount < maxPop
    if food.amount >= miner.cost
      food.amount -= miner.cost
      worker.amount++
      miner.amount++
      miner.cost++
      updateValues()
    else $('#info').prepend $("<p>You need more food.</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need to build more accommodation.</p>").fadeIn("slow")

$('#hireHunter').click ->
  if worker.amount < maxPop
    if food.amount >= hunter.cost
      food.amount -= hunter.cost
      worker.amount++
      hunter.amount++
      hunter.cost++
      updateValues()
    else $('#info').prepend $("<p>You need more food.</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need to build more accommodation.</p>").fadeIn("slow")

$('#hireMason').click ->
  if worker.amount < maxPop
    if food.amount >= mason.cost
      food.amount -= mason.cost
      worker.amount++
      mason.amount++
      mason.cost++
      updateValues()
    else $('#info').prepend $("<p>You need more food.</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need to build more accommodation.</p>").fadeIn("slow")

bldTent.mouseenter ->
  tentPriceText = for resource, price of tent.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: tentPriceText
    placement: "left"
    container: "body"
  return

bldTent.click ->
  if wood.amount >= tent.cost.wood
    wood.amount -= tent.cost.wood
    tent.amount += 1
    tent.cost.wood = (tent.cost.wood * 1.2).toFixed(0)
    maxPop += tent.residents
    document.getElementById('tentAmount').innerHTML = tent.amount
    document.getElementById('maxPop').innerHTML = maxPop
    updateValues()
    $(this).tooltip('destroy')
  else $('#info').prepend $("<p>You need more wood.</p>").fadeIn("slow")

bldHouse.mouseenter ->
  housePriceText = for resource, price of house.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: housePriceText
    placement: "left"
    container: "body"
  return

bldHouse.click ->
  if wood.amount >= house.cost.wood and stone.amount >= house.cost.stone
    wood.amount -= house.cost.wood
    stone.amount -= house.cost.stone
    house.amount += 1
    house.cost.wood = (house.cost.wood * 1.2).toFixed(0)
    house.cost.stone = (house.cost.stone * 1.2).toFixed(0)
    maxPop += house.residents
    document.getElementById("houseAmount").innerHTML = house.amount
    document.getElementById("maxPop").innerHTML = maxPop
    updateValues()
    bldHouse.tooltip('destroy')
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


$('#researchHostel').click ->
  progressWrap = document.getElemenyByClass("progress-wrap-hostel")
  if wood.amount >= 400 and stone.amount >= 150
    wood.amount -= 400
    stone.amount -= 150
    $('#researchHostel').addClass 'hidden'
    progressWrap.removeClass 'hidden'
    getPercent = (progressWrap.data("progress-percent-hostel") / 100)
    getProgressWrapWidth = progressWrap.width()
    progressTotal = getPercent * getProgressWrapWidth
    animationLength = 25000
    $('.progress-bar-hostel').stop().animate
      left: progressTotal
    , animationLength, ->
      $('#buildHostel').removeClass 'hidden'
      $('.progress-wrap-hostel').addClass 'hidden'
      $('.hostelInfo').removeClass 'hidden'
      $('.hostelResearchInfo').addClass 'hidden'
      return
    updateValues()
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")

$('#buildHostel').click ->
  if wood.amount >= hostel.cost.wood and stone.amount >= hostel.cost.stone
    wood.amount -= hostel.cost.wood
    stone.amount -= hostel.cost.stone
    hostel.amount += 1
    hostel.cost.wood = hostel.cost.wood * 1.2
    hostel.cost.stone = hostel.cost.stone * 1.2
    hostel.cost.wood = hostel.cost.wood.toFixed(0)
    hostel.cost.stone = hostel.cost.stone.toFixed(0)
    maxPop += hostel.residents
    updateValues()
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


bldMill.mouseenter ->
  millPrice = for resource, price of mill.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: millPrice
    placement: 'left'
    container: 'body'
  return

bldMill.click ->
  if wood.amount >= mill.cost.wood and stone.amount >= mill.cost.stone
    wood.amount -= mill.cost.wood
    stone.amount -= mill.cost.stone
    mill.amount += 1
    wood.max += 100
    document.getElementById("millAmount").innerHTML = mill.amount
    document.getElementById("maxWood").innerHTML = wood.max
    bldMill.tooltip('destroy')
    updateValues()
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")

bldQuarry.mouseenter ->
  quarryPrice = for resource, price of quarry.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: quarryPrice
    placement: "left"
    container: "body"
  return

bldQuarry.click ->
  if wood.amount >= quarry.cost.wood and stone.amount >= quarry.cost.stone
    wood.amount -= quarry.cost.wood
    stone.amount -= quarry.cost.stone
    quarry.amount += 1
    stone.max += 100
    updateValues()
    document.getElementById("quarryAmount").innerHTML = quarry.amount
    document.getElementById("maxStone").innerHTML = stone.max
    bldQuarry.tooltip('destroy')
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")



bldSilo.mouseenter ->
  siloPriceText = for resource, price of silo.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: siloPriceText
    placement: "left"
    container: "body"
  return

bldSilo.click ->
  if wood.amount >= silo.cost.wood and stone.amount >= silo.cost.stone
    wood.amount -= silo.cost.wood
    stone.amount -= silo.cost.stone
    silo.amount += 1
    food.max += 100
    updateValues()
    document.getElementById("siloAmount").innerHTML = silo.amount
    document.getElementById("maxFood").innerHTML = food.max
    bldSilo.tooltip("destroy")
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


bldMine.mouseenter ->
  minePriceText = for resource, price of mine.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: minePriceText
    placement: "left"
    container: "body"
  return

bldMine.click ->
  if wood.amount >= mine.cost.wood and stone.amount >= mine.cost.stone and ore.iron.amount >= mine.cost.iron
    wood.amount -= mine.cost.wood
    stone.amount -= mine.cost.stone
    ore.iron.amount -= mine.cost.iron
    mine.amount += 1
    ore.max += 100
    updateValues()
    document.getElementById("mineAmount").innerHTML = mine.amount
    document.getElementById("maxOre").innerHTML = ore.max
    bldMine.tooltip("destroy")
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


upSelf.mouseenter ->
  upSelfPriceText = for resource, price of self.upgrade
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: upSelfPriceText
    placement: 'left'
    container: 'body'
  return

# Upgrades
upSelf.click ->
  if resource.amount >= (price * self.increment).toFixed(0) for resource, price of self.upgrade
    resource.amount -= (price * self.increment).toFixed(0)
    self.increment += 1
    updateValues()
    $('#upgrades').prepend $("<p>Personal Ability | <span id='clickIncrement#{self.increment}'>#{self.increment}</span> Resources Per Click</p>").fadeIn("slow")
    upSelf.tooltip("destroy")
  else $('#info').prepend $("<p>You need more #{resource}.</p>").fadeIn("slow")

sleepingBags.mouseenter ->
  sleepingBagsPriceText = for resource, price of tent.upCost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: sleepingBagsPriceText
    placement: 'left'
    container: 'body'
  return

sleepingBags.click (event) ->
  if wood.amount >= 100 and ore.silver.amount >= 15 and ore.gold.amount >= 10
    $(event.currentTarget).addClass("hidden")
    wood.amount -= 100
    ore.silver.amount -= 15
    ore.gold.amount -= 10
    tent.residents = 2
    maxPop += tent.amount
    document.getElementById("maxPop").innerHTML = maxPop
    document.getElementById("tentResidents").innerHTML = tent.residents
    $('#upgrades').prepend $("<p>Double Sleeping Bags | Two People, One Tent</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

bunkBeds.mouseenter ->
  bunkBedPriceText = for resource, price of house.upCost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: bunkBedPriceText
    placement: 'left'
    container: 'body'
  return

bunkBeds.click ->
  if resource.amount >= price for resource, price of house.upCost
    resource.amount -= price for resource, price of house.upCost
    house.residents = 8
    maxPop += (house.amount * 2)
    document.getElementById("maxPop").innerHTML = maxPop
    document.getElementById("houseResidents").innerHTML = house.residents
    bunkBeds.addClass 'hidden'
    $('#upgrades').prepend $("<p>Bunk Beds | Eight People, One House</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

logInc.mouseenter ->
  logIncPrice = for resource, price of logger.incPrice
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: logIncPrice
    placement: 'left'
    container: 'body'
  return

logInc.click ->
  if resource.amount >= price for resource, price of logger.incPrice
    resource.amount -= price
    logger.increment += 1
    $('.upgradeSharpenAxes').addClass 'hidden'
    $('#upgrades').prepend $("<p>Sharpen Axes | Loggers Chop Two wood Each</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn('slow')

oreInc.mouseenter ->
  oreIncPrice = for resource, price of miner.incPrice
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: oreIncPrice
    placement: 'left'
    container: 'body'
  return

oreInc.click ->
  if wood.amount >= 50 and stone.amount >= 100 and food.amount >= 50
    wood.amount -= 50
    stone.amount -= 100
    food.amount -= 50
    miner.increment += 1
    $('.upgradeSharpenPicks').addClass 'hidden'
    $('#upgrades').prepend $("<p>Sharpen Picks | Miners get double resources.</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

stoneInc.mouseenter ->
  stoneIncPrice = for resource, price of mason.incPrice
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: stoneIncPrice
    placement: 'left'
    container: 'body'
  return

stoneInc.click ->
  if wood.amount >= 50 and stone.amount >= 100 and food.amount >= 50
    wood.amount -= 50
    stone.amount -= 100
    food.amount -= 50
    mason.increment += 1
    stone.increment = mason.increment * mason.amount
    $('.upgradeStrengthenShovels').addClass 'hidden'
    $('#upgrades').prepend $("<p>Strengthen Shovels | Masons get double resources.</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

foodInc.mouseenter ->
  foodIncPrice = for resource, price of hunter.incPrice
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: foodIncPrice
    placement: 'left'
    container: 'body'
  return

foodInc.click ->
  if wood.amount >= 50 and stone.amount >= 100 and food.amount >= 50
    wood.amount -= 50
    stone.amount -= 100
    food.amount -= 50
    hunter.increment += 1
    $('.upgradeSharpenArrows').addClass 'hidden'
    $('#upgrades').prepend $("<p>Sharpen Arrows | Hunters Gather Two Food Each</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

hagWood.mouseenter ->
  hagwoodPrice = for resource, price of carpentry.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: hagwoodPrice
    placement: 'left'
    container: 'body'
  return

hagWood.click ->
  if ore.gold.amount >= 25 and ore.silver.amount >= 50
    ore.gold.amount -= 25
    ore.silver.amount -= 50
    house.cost.wood -= 30
    tent.cost.wood -= 15
    hostel.cost.wood -= 40
    mill.cost.wood -= 25
    silo.cost.wood -= 25
    quarry.cost.wood -= 25
    mine.cost.wood -= 25
    bldHouse.tooltip 'destroy'
    bldTent.tooltip 'destroy'
    #$('buildHostel').tooltip 'destroy'
    $('buildMine').tooltip 'destroy'
    $('buildSilo').tooltip 'destroy'
    $('buildQuarry').tooltip 'destroy'
    $('buildMill').tooltip 'destroy'
    $(this).addClass 'hidden'
    $('#upgrades').prepend $("<p>Mates Rates - wood | Houses and Tents Cost Less wood</p>").fadeIn('slow')
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn('slow')

upMasonry.mouseenter ->
  masonryPriceText = for resource, price of masonry.cost
    "#{titleCase(resource)}: -#{price} "
  $(this).tooltip
    title: masonryPriceText
    placement: 'left'
    container: 'body'
  return

upMasonry.click ->
  if wood.amount >= 150 and food.amount >= 50
    wood.amount -= 150
    food.amount -= 50
    house.cost.stone -= 20
    hostel.cost.stone -= 40
    upMasonry.tooltip 'destroy'
    upMasonry.addClass 'hidden'
    $('#upgrades').prepend $("<p>Mates Rates - Stone | Houses Cost Less Stone</p>").fadeIn 'slow'
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn 'slow'
