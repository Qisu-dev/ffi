test "make sure null ptr exist" {
  assert_true(is_null(null_ptr()))
}

test "test errno" {
  assert_true(enoent() >= 0)
  assert_true(eacces() >= 0)
  assert_true(einval() >= 0)
}

test "errno get/set" {
  errno_set(42)
  assert_eq(errno_get(), 42)
  
  errno_set(0)
  assert_eq(errno_get(), 0)
}