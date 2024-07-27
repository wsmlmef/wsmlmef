<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>2024-AI烟花</title>
 
<style>
html, body {
   padding: 0;
   margin: 0;
   background: #222;
   font-family: 'Karla', sans-serif;
   color: #FFF;
   height: 100%;
   overflow: hidden;
}
h1 {
   z-index: 1000;
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -100%);
   font-size: 58px;
   border: 2px solid #FFF;
   padding: 7.5px 15px;
   background: rgba(0, 0, 0, 0.5);
   border-radius: 3px;
}
span { 
   display: inline-block;
   animation: drop 0.75s;
}
canvas {
   position: absolute;
   top: 0;
   left: 0;
}
 
@keyframes drop {
   0% { 
      transform: translateY(-100px);
      opacity: 0;
   }
   90% {
      opacity: 1;
      transform: translateY(10px);
   }
   100% {
      transform: translateY(0);
   }
}
</style>
</head>
<body>
 
<canvas></canvas>
 
<h1>202<span>4</span></h1>
 
<script type="text/javascript">
const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let sparks = [];
let fireworks = [];
for (let i = 0; i < 20; i++) {
   fireworks.push(new Firework(Math.random() * window.innerWidth, window.innerHeight * Math.random()));
}

function render() {
   setTimeout(render, 1000 / 60);
   ctx.fillStyle = 'rgba(0, 0, 0, 0.1)';
   ctx.fillRect(0, 0, canvas.width, canvas.height);
   fireworks.forEach(firework => {
      if (firework.dead) return;
      firework.move();
      firework.draw();
   });
   sparks.forEach(spark => {
      if (spark.dead) return;
      spark.move();
      spark.draw();
   });
   
   if (Math.random() < 0.05) {
      fireworks.push(new Firework());
   }
}
render();

function Spark(x, y, color) {
   this.x = x;
   this.y = y;
   this.dir = Math.random() * (Math.PI * 2);
   this.dead = false;
   this.color = color;
   this.speed = Math.random() * 3 + 3;
   this.walker = new Walker({ radius: 20, speed: 0.25 });
   this.gravity = 0.25;
   this.dur = this.speed / 0.1;
   this.move = function() {
      this.dur--;
      if (this.dur < 0) this.dead = true;
      if (this.speed > 0) this.speed -= 0.1;
      const walk = this.walker.step();
      this.x += Math.cos(this.dir + walk) * this.speed;
      this.y += Math.sin(this.dir + walk) * this.speed;
      this.y += this.gravity;
      this.gravity += 0.05;
   };
   this.draw = function() {
      drawCircle(this.x, this.y, 3, this.color);
   };
}

function Firework(x, y) {
   this.xmove = new Walker({ radius: 10, speed: 0.5 });
   this.x = x || Math.random() * canvas.width;
   this.y = y || canvas.height;
   this.height = Math.random() * canvas.height / 2;
   this.dead = false;
   this.color = randomColor();
   this.move = function() {
      this.x += this.xmove.step();
      if (this.y > this.height) this.y -= 1; 
      else this.burst();
   };
   this.draw = function() {
      drawCircle(this.x, this.y, 1, this.color);
   };
   this.burst = function() {
      this.dead = true;
      for (let i = 0; i < 100; i++) {
         sparks.push(new Spark(this.x, this.y, this.color));
      }
   };
}

function drawCircle(x, y, radius, color) {
   ctx.fillStyle = color || '#FFF';
   ctx.fillRect(x - radius / 2, y - radius / 2, radius, radius);
}

function randomColor() {
   const colors = ['#6ae5ab', '#88e3b2', '#36b89b', '#7bd7ec', '#66cbe1'];
   return colors[Math.floor(Math.random() * colors.length)];
}

function Walker(options) {
   this.step = function() {
      this.direction = Math.sign(this.target) * this.speed;
      this.value += this.direction;
      if (this.target) {
         this.target -= this.direction;
      } else if (this.value) {
         if (this.wander) {
            this.target = this.newTarget();
         } else {
            this.target = -this.value;
         }
      } else {
         this.target = this.newTarget();
      }
      return this.direction;
   };
   this.newTarget = function() {
      return Math.round(Math.random() * (this.radius * 2) - this.radius);
   };
   this.start = 0;
   this.value = 0;
   this.radius = options.radius;
   this.target = this.newTarget();
   this.direction = Math.sign(this.target);
   this.wander = options.wander;
   this.speed = options.speed || 1;
}
</script>
 
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
<p>适用浏览器：360、FireFox、Chrome、Opera、傲游、搜狗、世界之窗. 不支持Safari、IE8及以下浏览器。</p>
</div>

<script>
document.write('<script src="//' + (location.host || 'localhost').split(':')[0] + ':35929/livereload.js?snipver=1"><\/script>');
document.addEventListener('LiveReloadDisconnect', function() {
   setTimeout(function() {
      window.location.reload();
   }, 500);
});
</script>

</body>
</html>
