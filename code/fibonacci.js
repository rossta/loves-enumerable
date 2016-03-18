// $ node --harmony_destructuring fibonacci.js
function* fibonacci(limit){
  var [a, b, c] = [0, 1, 0];
  while(c < limit) {
    yield a
    var [a, b, c] = [b, a+b, c+1]
  }
}

for (var g of fibonacci(100)) {
  console.log(g.value);
}
