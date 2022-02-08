# Домашнее задание по лекции "Введение в Golang"

## 3.1
```buildoutcfg

package main

import "fmt"

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input / 0.3048

    fmt.Println(output)    
}

```

## 3.2 
```buildoutcfg
package main

import "fmt"

func main() {
  x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 1}
  res := x[0]
  for i := 0; i < len(x); i++ {
    if x[i] < res {
      res = x[i]
    }
  }
  fmt.Println(res)
}
```

## 3.3
```buildoutcfg
package main

import "fmt"

func main() {

  for i := 1; i < 101; i++ {
    if (i % 3) == 0 {
      fmt.Println(i)
    }
  }

}
```