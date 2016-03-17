var hello = function *(name) {
  yield 'Your name is ' + name;
  return 'Hello ' + name;
};

var gen = hello('Ross');
console.log(gen.next());
console.log(gen.next());
