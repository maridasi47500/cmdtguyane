module MyhelperHelper
  def addvues
    @post.update(vues: (@post.vues.to_i + 1))
  end
end
