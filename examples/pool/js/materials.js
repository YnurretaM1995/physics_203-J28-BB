// materials.js
// Système de matériaux et shaders pour la table de billard

import * as THREE from 'three';

/**
 * Shader personnalisé pour le tapis de billard
 * Simule le grain du feutre avec du bruit procédural
 */
export function createFeltMaterial() {
    const feltShader = {
        uniforms: {
            baseColor: { value: new THREE.Color(0x1aad42) },
            darkColor: { value: new THREE.Color(0x2b1d42) },
            lightColor: { value: new THREE.Color(0x2bedaa) },
            time: { value: 0.0 },
            noiseScale: { value: 20.0 },
            grainIntensity: { value: 0.01 }
        },
        
        vertexShader: `
            varying vec2 vUv;
            varying vec3 vNormal;
            varying vec3 vPosition;
            
            void main() {
                vUv = uv;
                vNormal = normalize(normalMatrix * normal);
                vPosition = position;
                gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
            }
        `,
        
        fragmentShader: `
            uniform vec3 baseColor;
            uniform vec3 darkColor;
            uniform vec3 lightColor;
            uniform float noiseScale;
            uniform float grainIntensity;
            
            varying vec2 vUv;
            varying vec3 vNormal;
            varying vec3 vPosition;
            
            // Fonction de bruit simplex 2D simplifiée
            float noise(vec2 p) {
                return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
            }
            
            float smoothNoise(vec2 p) {
                vec2 i = floor(p);
                vec2 f = fract(p);
                f = f * f * (3.0 - 2.0 * f);
                
                float a = noise(i);
                float b = noise(i + vec2(1.0, 0.0));
                float c = noise(i + vec2(0.0, 1.0));
                float d = noise(i + vec2(1.0, 1.0));
                
                return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
            }
            
            void main() {
                // Grain du feutre
                vec2 noiseCoord = vPosition.xz * noiseScale;
                float grain = smoothNoise(noiseCoord);
                grain = grain * 2.0 - 1.0;
                
                // Variation de couleur basée sur le grain
                vec3 color = baseColor;
                color = mix(color, darkColor, grain * grainIntensity * 0.5 + 0.5);
                
                // Légère variation directionnelle (simule le brossage du feutre)
                float brushPattern = sin(vPosition.x * 600.)    * grain * .02;
                color = mix(color, lightColor,brushPattern);
                
                // Éclairage simple basé sur la normale
                vec3 lightDir = normalize(vec3(0.0, 1.0, 0.2));
                float diffuse = max(dot(vNormal, lightDir), 0.9);
                float gamma = 2.0;
                gl_FragColor = vec4(color * diffuse * gamma, 1.0);
            }
        `
    };
    
    return new THREE.ShaderMaterial({
        uniforms: feltShader.uniforms,
        vertexShader: feltShader.vertexShader,
        fragmentShader: feltShader.fragmentShader,
        side: THREE.FrontSide,  // Une seule face pour éviter le z-fighting
        lights: false  // Éclairage personnalisé dans le shader
    });
}

/**
 * Matériau pour les bandes (cushions)
 */
export function createCushionMaterial() {
    return new THREE.MeshStandardMaterial({
        color: 0x247a46,
        roughness: 0.6,
        metalness: 0.0,
        side: THREE.FrontSide
    });
}

/**
 * Matériau pour le cadre en bois
 */
export function createWoodMaterial() {
    return new THREE.MeshStandardMaterial({
        color: 0x5c4033,
        roughness: 0.4,
        metalness: 0.0,
        side: THREE.FrontSide
    });
}

/**
 * Matériau pour les trous (pockets)
 */
export function createPocketMaterial() {
    return new THREE.MeshBasicMaterial({
        color: 0x000000,
        side: THREE.DoubleSide
    });
}

/**
 * Applique les matériaux appropriés au modèle GLB
 */
export function applyMaterialsToModel(model) {
    const feltMat = createFeltMaterial();
    const cushionMat = createCushionMaterial();
    const woodMat = createWoodMaterial();
    
    console.log('Application des matériaux au modèle...');
    
    model.traverse((child) => {
        if (child.isMesh) {
            console.log(`Mesh: "${child.name}"`);
            
            child.receiveShadow = true;
            child.castShadow = true;
            
            const name = child.name.toLowerCase();
            console.log(`Nom: "${name}"`);
            // Tapis (surface de jeu)
            if (name.includes('felt') || name.includes('table') || 
                name.includes('tapis') || name.includes('surface')) {
                child.material = feltMat;
                console.log('  → Shader TAPIS appliqué');
            }
            // Bandes
            else if (name.includes('cushion') || name.includes('rail') || 
                     name.includes('bande') || name.includes('rubber')) {
                child.material = cushionMat;
                console.log('  → Matériau BANDE appliqué');
            }
            // Cadre/Bois
            else if (name.includes('frame') || name.includes('wood') || 
                     name.includes('bois') || name.includes('cadre')) {
                child.material = woodMat;
                console.log('  → Matériau BOIS appliqué');
            }
            // Par défaut (probablement le tapis)
            else {
                child.material = feltMat;
                console.log('  → Shader TAPIS (défaut) appliqué');
            }
            
            // Désactiver le frustum culling pour éviter les problèmes de rendu
            child.frustumCulled = false;
        }
        else {
            console.log(child.name);
        }
    });
}
