package com.imajuk.tdf
{
    import flash.utils.Dictionary;

    /**
     * @author imajuk
     */
    public class March
    {
        private var mapper : GraphMapper;
        private var enemyUnits : Vector.<EnemyUnit> = new Vector.<EnemyUnit>();
        private var unitFrom : Dictionary = new Dictionary(true);
        private var unitTo   : Dictionary = new Dictionary(true);
        private var unitTime : Dictionary = new Dictionary(true);

        public function March(mapper : GraphMapper)
        {
            this.mapper = mapper;
        }

        public function addEnemyUnit(enemy : EnemyUnit) : void
        {
            enemyUnits.push(enemy);
            unitTime[enemy] = 0.0;
            resetEnemyFrom(enemy);
        }
        
        public function update() : void
        {
            var enemy : EnemyUnit,  // 敵軍ユニット
                from  : GraphNode,  // 敵軍ユニットの所属ノード
                to    : GraphNode,  // 敵軍ユニットの行き先ノード
                time  : Number,     // 敵軍ユニットの進軍時間
                i : int , l : int = enemyUnits.length;
                
            for (i = 0; i < l; i++)
            {
                enemy = enemyUnits[i];
                from  = unitFrom[enemy];
                to    = unitTo[enemy];
                time  = unitTime[enemy];

                // まだ敵軍ユニットの行き先が決まってなければ決定する
                if (!to) 
                    to = decideDestination(enemy, from);
                    
                // 敵軍ユニットの座標を取得してビューの位置を変更
                var position:Vector.<Number> = mapper.getPosition(from, to, time);
                enemy.x = position[0];
                enemy.y = position[1];
                
                //　敵軍ユニットが行き先ノードに達したら所属ノードを更新
                if (time >= 1.0)
                {
                    updateEnemyFrom(enemy, to);
                    unitTime[enemy] = 0.0;
                }
                unitTime[enemy] += .05 / to.cost * enemy.speed;
            }
        }

        private function resetEnemyFrom(enemy : EnemyUnit) : void
        {
            updateEnemyFrom(enemy, mapper.model.begin);
        }

        private function updateEnemyFrom(enemy : EnemyUnit, from : GraphNode) : void
        {
            unitFrom[enemy] = from;
            unitTo[enemy] = null;
        }

        private function decideDestination(enemy : EnemyUnit, node : GraphNode) : GraphNode
        {
            var prospectiveDestinations : Array = node.to,
            posibility : int = prospectiveDestinations.length;
            
            switch (posibility)
            {
                // 敵軍ユニットが終点に達した
                case 0:
                    // ゲームオーバーなど何らかの処理が必要になるが、いまはとりあえず始点に戻す
                    resetEnemyFrom(enemy);
                    return decideDestination(enemy, unitFrom[enemy]);
                    break;
                // 進路に分岐なし
                case 1:
                    return unitTo[enemy] = prospectiveDestinations[0];
                    break;
                // 進路に複数の分岐
                default :
                    // まだ分岐した進路を決定する仕組みを考えてないので複数進攻候補がある場合にはランダムに決定する
                    return unitTo[enemy] = prospectiveDestinations[int(Math.random() * posibility)];
            }
        }
    }
}
