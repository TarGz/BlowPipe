/* --------------------------------------------------------------------------------------*/
/*   ____   ____    _    ____    ____  _     ___  ______        ______ ___ ____  _____   */
/*  / ___| / ___|  / \  |  _ \  | __ )| |   / _ \|  _ \ \      / /  _ \_ _|  _ \| ____|  */
/*  \___ \| |     / _ \ | | | | |  _ \| |  | | | | |_) \ \ /\ / /| |_) | || |_) |  _|    */
/*   ___) | |___ / ___ \| |_| | | |_) | |__| |_| |  __/ \ V  V / |  __/| ||  __/| |___   */
/*  |____/ \____/_/   \_\____/  |____/|_____\___/|_|     \_/\_/  |_|  |___|_|   |_____|  */
/*                                                                                       */
/* --------------------------------------------------------------------------------------*/



/* --------------------------------------------------------------------------------------*/
/*                                                                                       */
/*           Parametric BlowPipe for Nerf darts by @targz (Julien Terraz)                */
/*           This work is licensed under the Creative Commons Attribution                */
/*           NonCommercial 4.0 International License. To view a copy of this             */
/*           license, visit http://creativecommons.org/licenses/by-nc/4.0/.              */
/*                                                                                       */
/* --------------------------------------------------------------------------------------*/


include <blowpipe.scad>;


/** DEMO
 * 
 * @param {boolean} hasGroove
 */
 $fn=100;
// demo(true);

/**  BLOW MODULE
 *
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
// blow(60,true);


/** Create blow pipes 
 * 
 * @param {number} PipeLength
 * @param {boolean} HasGroove
 */
 pipe(130,true);




