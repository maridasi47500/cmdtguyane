class MediathequeController < ApplicationController
  layout false, only: [:mavideo]
  def mavideo
    @vid=Video.findbycode(params[:code])
    render inline: @vid.datavideo
  end
  def searchvideo
    @nbparpage=6
    #session[:nbvid] ||= 1
    session[:nbvid]= session[:nbvid].to_i + @nbparpage
    @nb=session[:nbvid].to_i
    p @nb
    
    @nbfin=@nb+(@nbparpage - 1)
    p @nbfin
    @allvideos=Video.all
    @videos=@allvideos[@nb..@nbfin]
    
    @j= {
  "kind"=>"youtube#searchListResponse",
  "etag"=>"X3x7DfTfhp-3BqvLF1jO3G5Bams",
  "nextPageToken"=>"CB4QAA",
  "prevPageToken"=>"CBgQAQ",
  "regionCode"=>"GF",
  "pageInfo"=>{
    "totalResults"=>@allvideos.length,
    "resultsPerPage"=>@nbparpage
  },
  "items"=>@videos.map { |vid|
    {
      "kind"=>"youtube#searchResult",
      "etag"=>"IMZa-saGqTKpcP-n0z-E3kXQBCI",
      "id"=>{
        "kind"=>"youtube#video",
        "videoId"=>vid.datavideo
      },
      "snippet"=>{
        "publishedAt"=>DateTime.now.to_s,
        "channelId"=>"UCTFZ9lIxbWkZdY6jmYoNv-A",
        "title"=>vid.title,
        "description"=>"",
        "thumbnails"=>{
          "default"=>{
            "url"=>"/videothequefiles/"+vid.image,
            "width"=>120,
            "height"=>90
          },
          "medium"=>{
            "url"=>"/videothequefiles/"+vid.image,
            "width"=>320,
            "height"=>180
          },
          "high"=>{
            "url"=>"/videothequefiles/"+vid.image,
            "width"=>480,
            "height"=>360
          }
        },
        "channelTitle"=>"CMDTGuyane",
        "liveBroadcastContent"=>"none",
        "publishTime"=>"2020-12-22T05:38:47Z"
      }
    }
  }
}
    render json: @j
  end
  def index
    @post=Post.findbythetitle("mediatheque").locallink

  end
  def videotheque
    
    @post=Post.findbythetitle("videotheque")
    @post.modals=true
  end
  def phototheque
    @post=Post.findbythetitle("phototheque").locallink
  end
end
