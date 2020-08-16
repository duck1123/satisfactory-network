(ns satisfactory.doo-runner
  (:require [doo.runner :refer-macros [doo-tests]]
            [satisfactory.core-test]))

(doo-tests 'satisfactory.core-test)

