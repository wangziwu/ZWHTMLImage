Pod::Spec.new do |s|

  s.name    = 'ZWHTMLImage'
  s.version = '0.0.2'
  s.summary = 'iOS快速实现对WEB网页、HTML的native图片预览功能。两行代码调用、同时支持UIWebView与WKWebView。支持懒加载（滚动加载）类型HTML网页'
  s.homepage  = 'https://github.com/wangziwu/ZWHTMLImage'
  s.license = 'MIT'
  s.authors = {'wangziwu' =>  'wang_ziwu@126.com'}
  s.platform  = :ios,'8.0'
  s.ios.deployment_target = '8.0'
  s.source  = {:git => 'https://github.com/wangziwu/ZWHTMLImage.git',:tag => s.version}
  s.source_files  = 'ZWHTMLImage/*.{h,m}'
  s.resources     = 'ZWHTMLImage/*.{png,xib,nib,bundle}'
  s.requires_arc  = true
  s.dependency 'ZWPhotoPreview',  '~> 0.1.3'
end
