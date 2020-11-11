#ポケモンクラス

class Pokemon
  attr_accessor :name, :nicname, :level, :moves
  attr_reader :hp_iv, :attack_iv
  attr_writer :hp

  #levelの初期値
  MINIMUM_LEVEL = 1

  #ポケモンの技
  MOVE_LIST = {
    1 => "たいあたり!",
    2 => "ひっかく!",
    3 => "しっぽをふる!",
    4 => "でんきショック!",
    5 => "10まんボルト!"
  }

  DEFAULT_MOVE_IDS = [1, 2]

  #初期化したタイミングで属性が決定する
  def initialize(nicname: nil, level: nil)
    @name        = self.class::NAME
    @nicname     = nicname
    #levelが指定されなかったらMINIMUM_LEVELをセット
    @level       = level || MINIMUM_LEVEL
    #ランダムで配列から1件取得する
    @moves       = [DEFAULT_MOVE_IDS.sample]
    @hp_iv       = rand(0..31)
    @attack_iv   = rand(0..31)
  end
  
  def name
    nicname || @name
  end

  #レベルアップする
  def levelup!
    self.level += 1
    puts "レベルアップしました！"
    add_move if move_acquirable?
  end

  def moves_ja
    moves.map { |move_id| MOVE_LIST[move_id] }
  end

  #HPの取得
  def hp
    @hp ||= calc_hp_volume
  end

  #攻撃
  def attack!(target)
    puts "#{name} の #{moves_ja.sample}！"
    target.hp -= calc_attack_volume
    puts "#{target.name} に #{calc_attack_volume} のダメージ! 残り #{target.hp}"
  end

  #回復
  def heal!
    self.hp = calc_hp_volume
  end
  
  private

  #技を覚えられるかどうか > 2,5,10が含まれるかどうか?
  def move_acquirable?
    self.class::LEVELUP_MOVE_IDS.keys.include?(level)
  end

  #技を追加する
  def add_move
    self.moves <<= self.class::LEVELUP_MOVE_IDS[level]
  end

  #HPの計算
  def calc_hp_volume
    level * self.class::BASE_STATS + (hp_iv / 4).floor
  end

  #ダメージの計算
  def calc_attack_volume
    level * self.class::BASE_STATS + (attack_iv / 4).floor
  end
end