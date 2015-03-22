require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  fixtures :short_urls

  test "Should add a URL but not allow duplication" do
    assert_difference('ShortUrl.count', 1) do
      ShortUrl.create url: 'dondenoncourt.com'
    end

    assert ShortUrl.create(url: 'dondenoncourt.com').errors[:url].any?
  end

  test "Should not allow write access to mini_url" do
    assert_raises(ActiveRecord::UnknownAttributeError) { ShortUrl.create url: 'newone.com', mini_url: 'bad' }
  end

  test "Should be sparse, specifically having the property that no two short URLs should differ by only one character" do
    su = ShortUrl.create url: 'one.com'
    su.send(:write_attribute, :mini_url, 'abcde')
    su.save
    assert !ShortUrl.send(:is_sparse?, 'bbcde')
    assert !ShortUrl.send(:is_sparse?, 'accde')
    assert !ShortUrl.send(:is_sparse?, 'abdde')
    assert !ShortUrl.send(:is_sparse?, 'abcee')
    assert !ShortUrl.send(:is_sparse?, 'abcdf')
    assert  ShortUrl.send(:is_sparse?, 'hijklm')
  end

  test "Should handle transcribe errors by replacing 0, 6, and 1 with o, b, and l in the private method" do
    assert_equal 'ob', ShortUrl.send(:replace_char_alts, '06')
  end

  test "Should handle transcribe errors by replacing 0, 6, and 1 with o, b, and l on user input" do
    su = ShortUrl.create url: 'three.com'
    su.send(:write_attribute, :mini_url, 'oblobl')
    su.save
    assert ShortUrl.url_for('061061')
  end

  test "Should not allow the creation of a mini url that contains a bad word" do
    assert ShortUrl.send(:has_bad_words?, 'xfooxx')
    assert ShortUrl.send(:has_bad_words?, 'xxbarx')
    assert ShortUrl.send(:has_bad_words?, 'foobar')
    assert !ShortUrl.send(:has_bad_words?, 'abcedf')
  end

end
