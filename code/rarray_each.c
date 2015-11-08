/* array.c */
VALUE
rb_ary_each(VALUE array)
{
  long i;
  volatile VALUE ary = array;

  RETURN_SIZED_ENUMERATOR(ary, 0, 0, rb_ary_length);
  for (i=0; i<RARRAY_LEN(ary); i++) {
    rb_yield(RARRAY_PTR(ary)[i]);
  }
  return ary;
}
