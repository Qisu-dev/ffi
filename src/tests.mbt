test "make sure null ptr exist" {
  assert_true(is_null(null_ptr()))
}

test "test errno" {
  assert_true(enoent() >= 0)
  assert_true(eacces() >= 0)
  assert_true(einval() >= 0)
}

test "errno get/set" {
  set_errno(42)
  assert_eq(get_errno(), 42)
  
  set_errno(0)
  assert_eq(get_errno(), 0)
}