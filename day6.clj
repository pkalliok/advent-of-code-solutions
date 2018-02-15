(def input 
  (->> "tmp/day6.txt"
    slurp
    (#(clojure.string/split % #"\t"))
    (map clojure.string/trim)
    (mapv #(Integer/parseInt %))))

(defn spread [board cup]
  (let [beans (get board cup)
        cups (count board)
        extra (mod beans cups)]
    (mapv + (repeat (quot beans cups))
          (map #(if (< (mod (- % cup 1) cups) extra) 1 0) (range))
          (map #(if (= cup %) 0 (get board %)) (range cups)))))

(defn index-of [elem coll]
  (first (keep-indexed #(when (= %2 elem) %1) coll)))

(defn pick-cup [board] (index-of (apply max board) board))

(defn states [board] (iterate #(spread % (pick-cup %)) board))

(defn find-loop [states]
  (reduce #(if (%1 %2) (reduced [%1 %2]) (conj %1 %2)) #{} states))

(let [st (states input)
      [loopstates repeatedstate] (find-loop st)
      total-length (count loopstates)
      before-loop-length (index-of repeatedstate st)
      loop-length (- total-length before-loop-length)]
  (println total-length)
  (println loop-length))

