# Test lib/more/add/facets/xoxo.rb

require 'facets/xoxo.rb'
require 'test/unit'

  class TCXOXO < Test::Unit::TestCase

    def test_simple_list
      l = ['1', '2', '3']
      html = XOXO.dump(l)
      assert_equal '<ol class="xoxo"><li>1</li><li>2</li><li>3</li></ol>', html
    end

    def test_nested_list
      l = ['1', ['2', '3']]
      assert_equal '<ol class="xoxo"><li>1</li><li><ol><li>2</li><li>3</li></ol></li></ol>', XOXO.dump(l)
    end

    def test_hash
      h = {'test' => '1', 'name' => 'Kevin'}
      # Changed since Ruby sorts the hash differently.
      assert_equal '<ol class="xoxo"><li><dl><dt>name</dt><dd>Kevin</dd><dt>test</dt><dd>1</dd></dl></li></ol>', XOXO.dump(h)
    end

    def test_single_item
      l = 'test'
      assert_equal '<ol class="xoxo"><li>test</li></ol>', XOXO.dump(l)
    end

    def test_wrap_differs
      l = 'test'
      html = XOXO.dump(l)
      html_wrap = XOXO.dump(l, :html_wrap => true)
      assert_not_equal html, html_wrap
    end

    def test_wrap_single_item
      l = 'test'
      html = XOXO.dump(l, :html_wrap => true)
      assert_equal <<EOF.strip, html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN
http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head profile=""><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body><ol class="xoxo"><li>test</li></ol></body></html>
EOF
    end

    def test_wrap_item_with_css
      l = 'test'
      html = XOXO.dump(l, :html_wrap => true, :css => 'reaptest.css')
      assert_equal <<EOF.strip, html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN
http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head profile=""><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><style type="text/css" >@import "reaptest.css";</style></head><body><ol class="xoxo"><li>test</li></ol></body></html>
EOF
    end

    def test_hash_roundtrip
      h = {'test' => '1', 'name' => 'Kevin'}
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_hash_with_url_roundtrip
      h = {'url' => 'http://example.com', 'name' => 'Kevin'}
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_nested_hash_roundtrip
      h = {'test' => '1', 'inner' => {'name' => 'Kevin'}}
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_nested_hash_with_url_roundtrip
      h = {'url' => 'http://example.com', 'inner' => {
            'url' => 'http://slashdot.org', 'name' => 'Kevin'}}
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_list_round_trip
      l = ['3', '2', '1']
      assert_equal l, XOXO.load(XOXO.dump(l))
    end

    def test_list_of_hashes_round_trip
      l = ['3', {'a' => '2'}, {'b' => '1', 'c' => '4'}]
      assert_equal l, XOXO.load(XOXO.dump(l))
    end

    def test_list_of_lists_round_trip
      l = ['3', ['a', '2'], ['b', ['1', ['c', '4']]]]
      assert_equal l, XOXO.load(XOXO.dump(l))
    end

    def test_hashes_of_lists_roundtrip
      h = {
        'test' => ['1', '2'],
        'name' => 'Kevin',
        'nestlist' => ['a', ['b', 'c']],
        'nestdict' => {'e' => '6', 'f' => '7'}
      }
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_xoxo_junk_in_containers
      h = XOXO.load '<ol>bad<li><dl>worse<dt>good</dt><dd>buy</dd> now</dl></li></ol>'
      assert_equal({'good' => 'buy'}, h)
    end

    def test_xoxo_junk_in_elements
      l = XOXO.load '<ol><li>bad<dl><dt>good</dt><dd>buy</dd></dl>worse</li><li>bag<ol><li>OK</li></ol>fish</li></ol>'
      assert_equal([{'good' => 'buy'}, ['OK']], l)
    end

    def test_xoxo_with_spaces_and_newlines
      xoxo_sample = <<EOF.strip
<ol class='xoxo'>
  <li>
    <dl>
        <dt>text</dt>
        <dd>item 1</dd>
        <dt>description</dt>
        <dd> This item represents the main point we're trying to make.</dd>
        <dt>url</dt>
        <dd>http://example.com/more.xoxo</dd>
        <dt>title</dt>
        <dd>title of item 1</dd>
        <dt>type</dt>
        <dd>text/xml</dd>
        <dt>rel</dt>
        <dd>help</dd>
    </dl>
  </li>
</ol>
EOF
      h = XOXO.load xoxo_sample
      h2 = {
        'text' => 'item 1',
        'description' => " This item represents the main point we're trying to make.",
        'url' => 'http://example.com/more.xoxo',
        'title' => 'title of item 1',
        'type' => 'text/xml',
        'rel' => 'help'
      }
      assert_equal h2, XOXO.load(xoxo_sample)
    end

    def test_special_attribute_decoding
      xoxo_sample = <<EOF.strip
<ol class='xoxo'>
  <li>
    <dl>
        <dt>text</dt>
        <dd>item 1</dd>
        <dt>url</dt>
        <dd>http://example.com/more.xoxo</dd>
        <dt>title</dt>
        <dd>title of item 1</dd>
        <dt>type</dt>
        <dd>text/xml</dd>
        <dt>rel</dt>
        <dd>help</dd>
    </dl>
  </li>
</ol>
EOF
      smart_xoxo_sample = <<EOF.strip
<ol class='xoxo'>
  <li><a href="http://example.com/more.xoxo"
         title="title of item 1"
         type="text/xml"
         rel="help">item 1</a>
<!-- note how the "text" property is simply the contents of the <a> element -->
  </li>
</ol>
EOF
      assert_equal XOXO.load(xoxo_sample), XOXO.load(smart_xoxo_sample)
    end

    def test_special_attribute_and_dl_decoding
      xoxo_sample = <<EOF.strip
<ol class="xoxo">
  <li>
    <dl>
        <dt>text</dt>
        <dd>item 1</dd>
        <dt>description</dt>
        <dd> This item represents the main point we're trying to make.</dd>
        <dt>url</dt>
        <dd>http://example.com/more.xoxo</dd>
        <dt>title</dt>
        <dd>title of item 1</dd>
        <dt>type</dt>
        <dd>text/xml</dd>
        <dt>rel</dt>
        <dd>help</dd>
    </dl>
  </li>
</ol>
EOF
      smart_xoxo_sample = <<EOF.strip
<ol class="xoxo">
  <li><a href="http://example.com/more.xoxo"
         title="title of item 1"
         type="text/xml"
         rel="help">item 1</a>
<!-- note how the "text" property is simply the contents of the <a> element -->
      <dl>
        <dt>description</dt>
          <dd> This item represents the main point we're trying to make.</dd>
      </dl>
  </li>
</ol>
EOF
      assert_equal XOXO.load(xoxo_sample), XOXO.load(smart_xoxo_sample)
    end

    def test_special_attribute_encode
      h = {
        'url' => 'http://example.com/more.xoxo',
        'title' => 'sample url',
        'type' => "text/xml",
        'rel' => 'help',
        'text' => 'an example'
      }
      assert_equal '<ol class="xoxo"><li><a href="http://example.com/more.xoxo" title="sample url" rel="help" type="text/xml" >an example</a></li></ol>', XOXO.dump(h)
    end

    def test_special_attribute_roundtrip_full
      h = {
        'url' => 'http://example.com/more.xoxo',
        'title' => 'sample url',
        'type' => "text/xml",
        'rel' => 'help',
        'text' => 'an example'
      }
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_special_attribute_roundtrip_no_text
      h = {
        'url' => 'http://example.com/more.xoxo',
        'title' => 'sample url',
        'type' => "text/xml",
        'rel' => 'help'
      }
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_special_attribute_roundtrip_no_text_or_title
      h = {'url' => 'http://example.com/more.xoxo'}
      assert_equal h, XOXO.load(XOXO.dump(h))
    end

    def test_attention_roundtrip
      kmattn = <<EOF.strip
<ol class="xoxo"><li><a href="http://www.boingboing.net/" title="Boing Boing Blog" >Boing Boing Blog</a><dl><dt>alturls</dt><dd><ol><li><a href="http://boingboing.net/rss.xml" >xmlurl</a></li></ol></dd><dt>description</dt><dd>Boing Boing Blog</dd></dl></li><li><a href="http://www.financialcryptography.com/" title="Financial Cryptography" >Financial Cryptography</a><dl><dt>alturls</dt><dd><ol><li><a href="http://www.financialcryptography.com/mt/index.rdf" >xmlurl</a></li></ol></dd><dt>description</dt><dd>Financial Cryptography</dd></dl></li><li><a href="http://hublog.hubmed.org/" title="HubLog" >HubLog</a><dl><dt>alturls</dt><dd><ol><li><a href="http://hublog.hubmed.org/index.xml" >xmlurl</a></li><li><a href="http://hublog.hubmed.org/foaf.rdf" >foafurl</a></li></ol></dd><dt>description</dt><dd>HubLog</dd></dl></li></ol>
EOF
      assert_equal kmattn, XOXO.dump(XOXO.load(kmattn))
      assert_equal XOXO.load(kmattn), XOXO.load(XOXO.dump(XOXO.load(kmattn)))
      assert_equal XOXO.dump(XOXO.load(kmattn)),
                  XOXO.dump(XOXO.load(XOXO.dump(XOXO.load(kmattn))))
    end

    def test_unicode_roundtrip
      unicode = "Tantek \xc3\x87elik and a snowman \xe2\x98\x83"
      assert_equal unicode, XOXO.load(XOXO.dump(unicode))
    end

  # TBD:  Implement proper encodings.
  #
  #  def test_utf8_roundtrip
  #  end
  #  def test_windows1252_roundtrip
  #  end
  end
