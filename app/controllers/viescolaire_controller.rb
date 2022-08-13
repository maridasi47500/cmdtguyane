class ViescolaireController < ApplicationController
  include MyhelperHelper

  after_action :addvues, only: [:index]
  def index
    @post=Article.findbythetitle("vie sc")
  end
  def inscription
    @post=Article.findbythetitle("inscription re inscriptions 2021")
    
  end
  def lesdisciplines
    @post=Article.findbythetitle("disciplines")
    
  end
  def departements
    @post=Article.findbythetitle("départements").locallink
  end
  def musique
      @post=Article.findbyexacturl("/musique")
   
  end
  def danse
      @post=Article.findbyexacturl("/danse")
   
  end

  def cursus
     @post=Article.findbythetitle("cursus")
   
  end
  def lecursusmusique
    @post=Article.findbythetitle("les%cursus")
    
  end
  def lecursusdanse
    @post=Article.findbythetitle("cursus formation")
    
  end
  def reglementeleves
     @post=Article.findbythetitle("intérieur")
   
  end
  def projetdetablissement
    @post=Article.findbyexacturl("/projet-detablissement")
    
  end
  def lereglementdesetudes
       @post=Article.findbythetitle("glement%études")
 
  end
end
