module ApplicationHelper
  def default_meta_tags
    {
      title: 'Unlock',
      description: 'リアル実績解除アプリ',
      keywords: '実績,トロフィー,リアル,人生,Achievement,Torophy,Unlock',
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: images_ogp_url,
        locale: 'ja_JP'
      },
      twitter: {
        site: '@enimi_chan',
        card: 'summary_large_image'
      }
    }
  end
end
