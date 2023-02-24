let __ = let rec f _ = Obj.repr f in Obj.repr f

let boum =
  g __ (Obj.magic __)
