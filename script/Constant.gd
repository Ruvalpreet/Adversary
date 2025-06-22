class_name Constants extends Node


const ENEMY = "ENEMY"
const PLAYER = "PLAYER"
const ENEMY_BUILDING = "ENEMY_BUILDING"
const PLAYER_BUILDING = "PLAYER_BUILDING"
const PLAYER_ADVERSARY: Array[String] =[ENEMY, ENEMY_BUILDING];
const ENEMY_ADVERSARY: Array[String]= [PLAYER, PLAYER_BUILDING];

const ANIMATION_IDLE = 'idle';
const ANIMATION_SHOOT = 'shoot';
const ANIMATION_DEATH = 'death';

const PROJECTILE_VELOCITY:int = 1000;
const PROJECTILE_ANGLE_ERROR:float = 0.05;
