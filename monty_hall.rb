# 
# @author ksugimori
module MontyHall
  # 各ドアの後ろに置かれる景品
  module Prize
    # 当たり
    CAR  = "car"
    # はずれ
    GOAT = "goat"
  end

  # Monty Hall 問題シュミレート用クラス
  # @author ksugimori
  class Simulator
    # 初期化処理
    # 勝ち負けの結果カウントを 0 で初期化します。
    # @param [Fixnum] sample_size 試行回数
    def initialize(sample_size)
      @sample_size = sample_size
      @score = 0
    end

    # sample_size 回数分ゲームを実行します
    def execute
      @sample_size.times do
        doors = [Prize::CAR, Prize::GOAT, Prize::GOAT].shuffle
        user_choice = choose_index

        # 挑戦者が選ばなかった扉でハズレの方を選ぶ
        host_choice = choose_index excludes: [user_choice, doors.find_index(Prize::CAR)]

        # もう一方の扉を選びなおす
        user_choice = choose_index excludes: [user_choice, host_choice]

        @score += 1 if Prize::CAR == doors[user_choice]
      end
    end

    # 結果を表示します
    def show_result
      percentage = (100.0 * @score / @sample_size).round(1)
      puts "------------------------"
      puts "N = #{@sample_size}"
      puts "------------------------"
      puts "WIN : #{@score} times."
      puts "LOSE: #{@sample_size - @score} times."
      puts "------------------------"
      puts "In this simulation, you've got a #{percentage} percent winning rate!"
    end


    private

    # [0, 1, 2] から指定されたリストに含まれる値を除き、その上でランダムに値を選択します
    # @param [Array] excludes 除外対象のリスト
    # @return 0, 1, 2 のいずれか。excludes に含まれる値が返ることはありません
    def choose_index(excludes: [])
      ([0, 1, 2] - excludes).sample
    end
  end
end