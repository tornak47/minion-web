<?php
/**
 * The main template file1.
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 * * @package WordPress
 * @subpackage Smoke
 * @since Smoke 1.0
 */

get_header(); ?>

				

                  
      </div>
    </div>
  </div>
</div>
<div class="top-frame-container" style="position: inherit">
<?php
$slides = get_option_tree( 'slide', $option_tree, false, true, -1 );
			  foreach( $slides as $slide ) { ?>
<div title="<?php echo $slide['title']?>" class="top-frame-slide" style="background:url('<?php echo $slide['image']?>')">
    </div>
<?php }?>
</div>
<div style=" clear:both;"></div>
<?php if ( function_exists( 'get_option_tree') ) : if( get_option_tree( 'disable_advert') ) : ?>
<?php else : ?>

<script type="text/javascript" src="http://cloud.github.com/downloads/malsup/cycle/jquery.cycle.all.latest.js"></script>

<script type="text/javascript">
    
    $(document).ready(function() {
       $('.top-frame-container').cycle({
       fx: 'fade', // choose your transition type, ex: fade, scrollUp etc
       timeout: 5000,
       after: function(currslideelement,nextslideelement){document.title=nextslideelement.title},
       pagerAnchorBuilder: function(idx, slide) { 
                  return '<a class="thumb" href="#"><img src="' + $(slide).css('background-image').replace("url(\"","").replace("\")","") + '" width="123px" height="50px" /></a>';},
       pager:('.slideshow')
});
});
</script>


<script type=text/javascript>
$(document).ready(function(){ 

    $(".thumb").hover(
        function(){           
            $('.top-frame-container').cycle('pause');
        },function(){
            $('.top-frame-container').cycle('resume');
        });
});
</script>

<script>
$(document).ready(function(){ 
     $(".thumb img:first").css('float','left').css('width','123px');
});
</script>

<script type/javascript>
     $(document).ready(function(){

$('.thumb img').fadeTo(1, 0.4);

 $('.thumb').hover(function(){
  $('img', this).stop().animate({opacity: 1});
 }, function() {
  $('img', this).stop().animate({opacity: 0.4});
 });
});


</script>
<div class='slideshow_box'>
     <div class='slideshow_shader'>
     </div>
     <div class='slideshow' overflow='hidden'>
     </div>
</div>

<?php endif; endif; ?> 



<?php if ( function_exists( 'get_option_tree') ) : if( get_option_tree( 'disable_tabmenu') ) : ?>
<?php else : ?>

<?php endif; endif; ?>


<!-- Social Start -->
<div class="container_16">
  <div class="grid_16" id="social-back-two">
    <div class="grid_10 social-area">
      <h1><?php get_option_tree( 'social_title', '', 'true' ); ?></h1>
      <p><?php get_option_tree( 'social_subtitle', '', 'true' ); ?></p>
    </div>
    <div class="grid_6 social-icon">
      <ul>
        <?php get_option_tree( 'social_list', '', 'true' ); ?>
      </ul>
    </div>
  </div>
</div>
<div style="clear:both;"></div>
<div style="margin-bottom:160px;"></div>
<!-- Social End -->

<?php get_footer(); ?>
