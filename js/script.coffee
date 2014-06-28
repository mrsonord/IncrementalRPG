"use strict"

$ = jQuery

# Variables
names =
  realm: ""
  king: ""

self =
  upgrade:
    wood: 100
    stone: 100
    food: 100
    silver: 0
    gold: 0

logger =
  increment: 1
  amount: 0
  cost: 10
  incPrice:
    iron: 20
    silver: 10
    gold: 5
miner =
  increment: 1
  amount: 0
  cost: 10
  incPrice:
    iron: 20
    silver: 10
    gold: 5
hunter =
  increment: 1
  amount: 0
  cost: 10
  incPrice:
    iron: 20
    silver: 10
    gold: 5
mason =
  increment: 1
  amount: 0
  cost: 10
  incPrice:
    iron: 20
    silver: 10
    gold: 5

worker =
  amount: 0

wood =
  name: "wood"
  amount: 0
  increment: 0
  max: 100
  flag: false

stone =
  name: "stone"
  amount: 0
  increment: 0
  max: 100
  flag: false

food =
  name: "food"
  amount: 0
  increment: 0
  max: 100
  flag: false

ore =
  name: "ore"
  increment: 0
  amount: 0
  max: 200
  flag: false
  iron:
    name: "iron"
    amount: 0

  copper:
    name: "copper"
    amount: 0

  silver:
    name: "silver"
    amount: 0

  gold:
    name: "gold"
    amount: 0

tent =
  amount: 0
  residents: 1
  cost:
    wood: 30
  upCost:
    wood: 70
    silver: 50
    gold: 25

house =
  amount: 0
  residents: 4
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
  cost:
    wood: 200
    stone: 215
    iron: 25

mine =
  amount: 0
  cost:
    wood: 100
    stone: 100
    iron: 25

quarry =
  amount: 0
  cost:
    wood: 100
    stone: 100
    iron: 0

silo =
  amount: 0
  cost:
    wood: 100
    stone: 100
    iron: 0

mill =
  amount: 0
  cost:
    wood: 100
    stone: 100
    iron: 0

haggleWood =
  cost:
    silver: 50
    gold: 25
masonry =
  cost:
    silver: 50
    gold: 25
clickIncrement = 1
maxPop = (tent.residents * tent.amount) + (house.residents * house.amount)
nIntervId = undefined
bunkBeds = $('#upgradeBunkBeds')
bldTent = $('#buildTent')
sleepingBags = $('#upgradeSleepingBags')
bldMine = $('#buildMine')
bldMill = $('#buildMill')
bldSilo = $('#buildSilo')
bldQuarry = $('#buildQuarry')
hagStone = $('#upgradeMasonry')
stoneInc = $('#upgradeStrengthenShovels')
hagWood = $('#upgradeCarpentry')
foodInc = $('#upgradeSharpenArrows')


# Display the correct values.
updateValues = ->
  document.getElementById("maxPop").innerHTML = maxPop
  document.getElementById("tentAmount").innerHTML = tent.amount
  #document.getElementById("tentCostwood").innerHTML = tent.cost.wood
  document.getElementById("tentResidents").innerHTML = tent.residents
  document.getElementById("houseAmount").innerHTML = house.amount
  #document.getElementById("houseCostwood").innerHTML = house.cost.wood
  #document.getElementById("houseCostStone").innerHTML = house.cost.stone
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
  document.getElementById("upgradeSelfTotal").innerHTML = clickIncrement
  return

# Test max resources
checkMaxwood = ->
  wood.amount = wood.max  if wood.amount >= wood.max
  return
checkMaxStone = ->
  stone.amount = stone.max  if stone.amount >= stone.max
  return
checkMaxFood = ->
  food.amount = food.max  if food.amount >= food.max
  return
checkMaxOre = ->
  oreTotal = ore.iron.amount + ore.copper.amount + ore.silver.amount + ore.gold.amount
  ore.amount = ore.max  if oreTotal >= ore.max
  return

# Loggers Gather wood
gatherWood = ->
  wood.amount += (logger.increment * logger.amount)
  checkMaxwood()
  updateValues()
  return

# Quarriers Gather Stone
gatherStone = ->
  stone.increment = mason.increment * mason.amount
  stone.amount += stone.increment
  checkMaxStone()
  updateValues()
  return

# Hunters Gather Food
gatherFood = ->
  food.increment = hunter.increment * hunter.amount
  food.amount += food.increment
  checkMaxFood()
  updateValues()
  return

# Miners Gather Ore
gatherOre = ->
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
  wood.amount += 100
  food.amount += 100
  beginTick = ->
    nIntervId = setInterval(tick, 5000)
    return
  tick = ->
    gatherWood()
    gatherStone()
    gatherFood()
    gatherOre()
    return
  $("#onLoadModal").modal()
  beginTick()
  updateValues()
  $("#modalClose").click ->
    names.realm = document.getElementById("realm").value
    document.getElementById("realmName").innerHTML = names.realm
    names.king = document.getElementById("king").value
    document.getElementById("kingName").innerHTML = names.king
    return
  bldTent.tooltip({
    title: tentPrice
    placement: 'left'
    container: 'body'
  })
  bunkBeds.tooltip({
    title: bunkBedPrice
    placement: 'left'
    container: 'body'
  })
  return

titleCase = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

$('#chopWood').click ->
  wood.amount += clickIncrement
  checkMaxwood()
  updateValues()
  return

$('#mineStone').click ->
  stone.amount += clickIncrement
  checkMaxStone()
  updateValues()
  return

$('#gatherFood').click ->
  food.amount += clickIncrement
  checkMaxFood()
  updateValues()
  return

$('#mineOre').click ->
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
    ore.iron.amount += clickIncrement
    ore.amount += clickIncrement
  else if oreChoice is "c"
    ore.copper.amount += clickIncrement
    ore.amount += clickIncrement
  else if oreChoice is "s"
    ore.silver.amount += clickIncrement
    ore.amount += clickIncrement
  else
    ore.gold.amount += clickIncrement
    ore.amount += clickIncrement
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
      wood.increment = logger.increment * logger.amount;
      updateValues()
    else $('#info').prepend $("<p>You need more food.</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need to build more accommodation.</p>").fadeIn("slow")

# Hire Miner
$('#hireMiner').click ->
  if worker.amount < maxPop
    if food.amount >= miner.cost
      food.amount -= miner.cost
      worker.amount++
      miner.amount++
      miner.cost++
      ore.increment = miner.increment * miner.amount
      document.getElementById("oreIncrement").innerHTML = ore.increment
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
      food.increment = hunter.increment * hunter.amount;
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
      stone.increment = stone.increment * stone.amount;
      updateValues()
    else $('#info').prepend $("<p>You need more food.</p>").fadeIn("slow")
  else $('#info').prepend $("<p>You need to build more accommodation.</p>").fadeIn("slow")

# Build a tent
bldTent.click ->
  tentPriceText = for resource, price of tent.cost
    "#{titleCase(resource)}: -#{price} "
  if wood.amount >= tent.cost.wood
    wood.amount -= tent.cost.wood
    tent.amount += 1
    tent.cost.wood = (tent.cost.wood * 1.2).toFixed(0)
    maxPop += tent.residents
    document.getElementById('tentAmount').innerHTML = tent.amount
    document.getElementById('maxPop').innerHTML = maxPop
    updateValues()
    bldTent.tooltip('destroy')
    bldTent.tooltip({
      title: tentPriceText
      placement: 'left'
      container: 'body'
    })
  else $('#info').prepend $("<p>You need more wood.</p>").fadeIn("slow")


bldHouse = $('#buildHouse')
housePriceText = for resource, price of house.cost
  "#{titleCase(resource)}: -#{price} "
bldHouse.tooltip({
  title: housePriceText
  placement: 'left'
  container: 'body'
})

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
    housePriceText = for resource, price of house.cost
      "#{titleCase(resource)}: -#{price} "
    bldHouse.tooltip({
      title: housePriceText
      placement: 'left'
      container: 'body'
    })
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


# Research Hostel
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


# Build a hostel
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



millPrice = for resource, price of mill.cost
  "#{titleCase(resource)}: -#{price} "
bldMill.tooltip({
  title: millPrice
  placement: 'left'
  container: 'body'
})
# Build wood storage
bldMill.click ->
  if wood.amount >= mill.cost.wood and stone.amount >= mill.cost.stone and ore.iron.amount >= mill.cost.iron
    wood.amount -= mill.cost.wood
    stone.amount -= mill.cost.stone
    ore.iron.amount -= mill.cost.iron
    mill.amount += 1
    wood.max += 100
    document.getElementById("millAmount").innerHTML = mill.amount
    document.getElementById("maxwood").innerHTML = wood.max
    bldMill.tooltip('destroy')
    millPrice = for resource, price of mill.cost
      "#{titleCase(resource)}: -#{price} "
    bldMill.tooltip({
      title: millPrice
      placement: 'left'
      container: 'body'
    })
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")

quarryPrice = for resource, price of quarry.cost
  "#{titleCase(resource)}: -#{price} "
bldQuarry.tooltip({
  title: quarryPrice
  placement: "left"
  container: "body"
})
# Build Stone storage
bldQuarry.click ->
  if wood.amount >= quarry.cost.wood and stone.amount >= quarry.cost.stone and Ore.iron.amount >= quarry.cost.iron
    wood.amount -= quarry.cost.wood
    stone.amount -= quarry.cost.stone
    ore.iron.amount -= quarry.cost.iron
    quarry.amount += 1
    stone.max += 100
    updateValues()
    document.getElementById("quarryAmount").innerHTML = quarry.amount
    document.getElementById("maxStone").innerHTML = stone.max
    bldQuarry.tooltip('destroy')
    quarryPrice = for resource, price of quarry.cost
      "#{titleCase(resource)}: -#{price} "
    bldQuarry.tooltip({
      title: quarryPrice
      placement: "left"
      container: "body"
    })
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")



siloPriceText = for resource, price of silo.cost
  "#{titleCase(resource)}: -#{price} "
bldSilo.tooltip({
  title: siloPriceText
  placement: "left"
  container: "body"
})
# Build Food storage
bldSilo.click ->
  if wood.amount >= silo.cost.wood and stone.amount >= silo.cost.stone and ore.iron.amount >= silo.cost.iron
    wood.amount -= silo.cost.wood
    stone.amount -= silo.cost.stone
    ore.iron.amount -= silo.cost.iron
    silo.amount += 1
    food.max += 100
    updateValues()
    document.getElementById("siloAmount").innerHTML = silo.amount
    document.getElementById("maxFood").innerHTML = food.max
    bldSilo.tooltip("destroy")
    siloPriceText = for resource, price of silo.cost
      "#{titleCase(resource)}: -#{price} "
    bldSilo.tooltip({
      title: siloPriceText
      placement: "left"
      container: "body"
    })
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


minePriceText = for resource, price of mine.cost
  "#{titleCase(resource)}: -#{price} "
bldMine.tooltip({
  title: minePriceText
  placement: "left"
  container: "body"
})
# Build Ore storage
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
    minePriceText = for resource, price of mine.cost
      "#{titleCase(resource)}: -#{price} "
    bldMine.tooltip({
      title: minePriceText
      placement: 'left'
      container: 'body'
    })
  else $('#info').prepend $("<p>You need more building materials.</p>").fadeIn("slow")


# Upgrades
$('#upgradeSelf').click ->
  upCost = self.increment * 100
  if self.increment <= 5
    if wood.amount >= upCost and stone.amount >= upCost and food.amount >= upCost
      wood.amount -= upCost
      stone.amount -= upCost
      food.amount -= upCost
      self.increment += 1
      $('#upgrades').append $("<p>Personal Ability | <span id='clickIncrement'>2</span> Resources Per Click</p>").fadeIn("slow")
      updateValues()
    else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")
  if self.increment <= 7
    SilverUpCost = upCost * 1.2
    GoldUpCost = upCost * 1.1
    if wood.amount >= upCost and stone.amount >= upCost and food.amount >= upCost and Ore.Silver.amount >= SilverUpCost and Ore.Gold.amount >= GoldUpCost
      wood.amount -= upCost
      stone.amount -= upCost
      food.amount -= upCost
      ore.silver.amount -= SilverUpCost
      ore.gold.amount -= GoldUpCost
      self.increment += 1
      $('#upgrades').append $("<p>Personal Ability | <span id='clickIncrement'>2</span> Resources Per Click</p>").fadeIn("slow")
      updateValues()
    else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

  #$('#upgradeFiveFingers').click ->
  #  if wood.amount >= 450 and stone.amount >= 450 and food.amount >= 120
  #    wood.amount -= 450
  #    stone.amount -= 450
  #    food.amount -= 120
  #    clickIncrement += 3
  #    $('.upgradeFiveFingers').addClass 'hidden'
  #    $('#upgrades").prepend $("<p>Five Fingers | Five Resources Per Click</p>").fadeIn("slow")
  #    updateValues()
  #  else
  #    $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")
  #  return


sleepingBagsPriceText = for resource, price of tent.upCost
  "#{titleCase(resource)}: -#{price} "
sleepingBags.tooltip({
  title: sleepingBagsPriceText
  placement: 'left'
  container: 'body'
})

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

bunkBedPriceText = for resource, price of house.upCost
  "#{titleCase(resource)}: -#{price} "
bunkBeds.tooltip({
  title: bunkBedPriceText
  placement: 'left'
  container: 'body'
})
bunkBeds.click ->
  if wood.amount >= 100 and stone.amount >= 50 and food.amount >= 100
    wood.amount -= 100
    stone.amount -= 50
    food.amount -= 50
    house.residents = 5
    maxPop += house.amount #Ore only works because we are adding ONE resident.
    bunkBeds.addClass 'hidden'
    $('#upgrades').prepend $("<p>Bunk Beds | Five People, One House</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

logInc = $('#upgradeSharpenAxes')
logIncPrice = for resource, price of logger.incPrice
  "#{titleCase(resource)}: -#{price} "
logInc.tooltip({
  title: logIncPrice
  placement: 'left'
  container: 'body'
})

logInc.click ->
  if wood.amount >= 50 and stone.amount >= 100 and food.amount >= 50
    wood.amount -= 50
    stone.amount -= 100
    food.amount -= 50
    logger.increment += 1
    $('.upgradeSharpenAxes').addClass 'hidden'
    $('#upgrades').prepend $("<p>Sharpen Axes | Loggers Chop Two wood Each</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

OreInc = $('#upgradeSharpenPicks')
OreIncPrice = for resource, price of miner.incPrice
  "#{titleCase(resource)}: -#{price} "
OreInc.tooltip({
  title: OreIncPrice
  placement: 'left'
  container: 'body'
})

OreInc.click ->
  if wood.amount >= 50 and stone.amount >= 100 and food.amount >= 50
    wood.amount -= 50
    stone.amount -= 100
    food.amount -= 50
    miner.increment += 1
    $('.upgradeSharpenPicks').addClass 'hidden'
    $('#upgrades').prepend $("<p>Sharpen Picks | Miners get double resources.</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

stoneIncPrice = for resource, price of mason.incPrice
  "#{titleCase(resource)}: -#{price} "
stoneInc.tooltip({
  title: stoneIncPrice
  placement: 'left'
  container: 'body'
})
stoneInc.click ->
  if wood.amount >= 50 and stone.amount >= 100 and food.amount >= 50
    wood.amount -= 50
    stone.amount -= 100
    food.amount -= 50
    mason.increment += 1
    $('.upgradeStrengthenShovels').addClass 'hidden'
    $('#upgrades').prepend $("<p>Strengthen Shovels | Masons get double resources.</p>").fadeIn("slow")
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn("slow")

foodIncPrice = for resource, price of hunter.incPrice
  "#{titleCase(resource)}: -#{price} "
foodInc.tooltip({
  title: foodIncPrice
  placement: 'left'
  container: 'body'
})

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


hagwoodPrice = for resource, price of haggleWood.cost
  "#{titleCase(resource)}: -#{price} "
hagWood.tooltip({
  title: hagwoodPrice
  placement: 'left'
  container: 'body'
})
hagWood.click ->
  hagWood = $('#upgradeCarpentry')
  if ore.gold.amount >= 150 and food.amount >= 50
    stone.amount -= 150
    food.amount -= 50
    house.cost.wood -= 25
    tent.cost.wood -= 15
    hostel.cost.wood -= 40
    hagWood.addClass 'hidden'
    $('#upgrades').prepend $("<p>Mates Rates - wood | Houses and Tents Cost Less wood</p>").fadeIn('slow')
    updateValues()
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn('slow')

upMasonry = $('#upgradeMasonry')
masonryPriceText = for resource, price of masonry.cost
  "#{titleCase(resource)}: -#{price} "
upMasonry.tooltip({
  title: masonryPriceText
  placement: 'left'
  container: 'body'
})
upMasonry.click ->
  if wood.amount >= 150 and food.amount >= 50
    wood.amount -= 150
    food.amount -= 50
    house.cost.stone -= 20
    hostel.cost.stone -= 40
    updateValues()
    upMasonry.tooltip('destroy')
    upMasonry.addClass 'hidden'
    $('#upgrades').prepend $("<p>Mates Rates - Stone | Houses Cost Less Stone</p>").fadeIn('slow')
    upMasonry.tooltip({
      title: masonryPriceText
      placement: 'left'
      container: 'body'
    })
  else $('#info').prepend $("<p>You need more resources.</p>").fadeIn('slow')
