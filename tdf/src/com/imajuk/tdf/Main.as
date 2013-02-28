package com.imajuk.tdf
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class Main extends Sprite
    {
        private var model : DirectedGraph;

        public function Main()
        {
            // テスト用の地形作成
            model = new DirectedGraph();
            // 敵軍進軍始点（ノードA）
            var node_A : GraphNode = model.begin;
            // ノードAにノードBを追加
            var node_B : GraphNode = node_A.add(2);
            // ノードBにノードCを追加
            var node_C : GraphNode = node_B.add(5);
            // ノードBにノードDを追加
            var node_D : GraphNode = node_B.add(2);
            // ノードCにノードEを追加
            var node_E : GraphNode = node_C.add(8);
            // ノードEに敵軍終点（ノードF）を追加
            var node_F : GraphNode = node_E.add(2);
            // ノードDとノードFを連結
            node_D.connect(node_F);
            
            // グラフを空間にマップするオブジェクト
            var mapper:GraphMapper = new GraphMapper(model);

            // テスト用の簡易ビュー
            var view:Sprite = addChild(new Terrain(model, mapper)) as Sprite;
            
            // 敵軍ユニット（スピード1、カラー青）
            var enemy1:EnemyUnit = view.addChild(new EnemyUnit(1.0, 0x0000ff)) as EnemyUnit;
            // 敵軍ユニット（スピード1.5、カラー赤）
            var enemy2:EnemyUnit = view.addChild(new EnemyUnit(1.5, 0xff6666)) as EnemyUnit;
            
            // 進軍クラス
            var march:March = new March(mapper);
            march.addEnemyUnit(enemy1);
            march.addEnemyUnit(enemy2);
            addEventListener(Event.ENTER_FRAME, function() : void
            {
                march.update();
            });
        }
    }
}