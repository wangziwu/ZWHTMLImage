Pod::Spec.new do |s|

  s.name    = 'ZWHTMLImage'
  s.version = '0.0.1'
  s.summary = '快速实现webview中网页图片原生预览'
  s.homepage  = 'https://github.com/wangziwu/ZWHTMLImage'
  s.license = 'MIT'
  s.authors = {'wangziwu' =>  'wang_ziwu@126.com'}
  s.platform  = :ios,'7.0'
  s.ios.deployment_target = '7.0'
  s.source  = {:git => 'https://github.com/wangziwu/ZWHTMLImage.git',:tag => s.version}
  s.source_files  = 'ZWHTMLImage/*.{h,m}'
  s.resources     = 'ZWHTMLImage/*.{png,xib,nib,bundle}'
  s.requires_arc  = true
  s.dependency 'ZWPreviewImage',  '~> 0.0.1'
end
