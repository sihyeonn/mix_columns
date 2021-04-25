# mix_columns
AES mix column calculator

## How to use
```ruby
> MixColumns.new.calculate!
```
or
```ruby
> MixColumns.new.calculate!('hex')
```

## Input
4x4 state array with binary values only.
- if you put 16 values in a row, you must put them in an order.
- if you put 4x4 array, you must put them transformed shape.
i.e., if I want to put [[1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16]] state.
then I can put them as an input like this but binary.
1. [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
2. [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]

## Output
4x4 state array.
