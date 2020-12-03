
(def raw-input (clojure.string/split-lines (slurp "tmp/day7.txt")))

(defn parse-input [input]
  (->> input
    (map (partial re-matches #"([^ ]*) \(([0-9]*)\)( -> (.*))?"))
    (map (fn [[_ p w _ ch]]
           [(keyword p) (Integer/parseInt w) 
            (if ch (map keyword (clojure.string/split ch #", *")) [])]))))

(defn prop-maps [parsed]
  (let [progs (map first parsed)
        weigths (map second parsed)
        children (map #(get % 2) parsed)]
    [progs (zipmap progs weigths) (zipmap progs children)]))

(defn solve [programs weight children]

  (def total-weight
    (memoize
      (fn [prog]
        (+ (weight prog)
           (reduce + (map total-weight (children prog)))))))

  (defn balanced? [prog]
    (->> (children prog) (map total-weight) set count (>= 1)))

  (defn smallest-unbalanced [progs]
    (->> progs (remove balanced?) (map #(vector (total-weight %) %))
      sort first second))

  (let [parent (smallest-unbalanced programs)
        ch (children parent)
        [wrong-weight right-weight]
         (->> ch (map total-weight) frequencies (map reverse) (map vec)
           sort (map second))
        wrong-ch (first (filter #(= wrong-weight (total-weight %)) ch))]
    (+ (weight wrong-ch) (- right-weight wrong-weight))))

(println (apply solve (prop-maps (parse-input raw-input))))

