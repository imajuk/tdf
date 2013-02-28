package com.imajuk.tdf
{
    import flash.display.Graphics;
    import flash.display.Sprite;

    /**
     * @author imajuk
     */
    public class EnemyUnit extends Sprite
    {
        public var speed : Number;
        private var color : uint;

        public function EnemyUnit(speed : Number = 1.0, color : uint = 0)
        {
            this.color = color;
            this.speed = speed;
            
            draw();
        }

        private function draw() : void
        {
            //とりあえず正方形を描画.いまはテストできればいい
            var g:Graphics = graphics;
            g.beginFill(color, .5);
            g.drawRect(-15, -15, 30, 30);
            g.endFill();
        }
    }
}
