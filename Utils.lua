-- expects b1 and b2 to have x, y, width and height properties
function Overlaps(b1, b2)
  if (b1.x + b1.width) < b2.x or b1.x > (b2.x + b2.width) then
    return false
  end

  if b1.y > (b2.y + b2.height) or (b1.y + b1.height) < b2.y then
    return false
  end

  return true
end
