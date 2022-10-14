(fn identity [x]
  x)

(fn map [f coll]
  (icollect [_ s (ipairs coll)]
    (f s)))

(fn ->str [x]
  (tostring x))

(fn str->chars [s]
  (icollect [char (string.gmatch (->str s) ".")] char))

(fn keys [t]
  (let [result []]
    (each [k _ (pairs t)] 
      (table.insert result k))
    result))

{: identity
 : map
 : ->str
 : str->chars
 : keys}