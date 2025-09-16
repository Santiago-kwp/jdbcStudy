CREATE TABLE `customer` (
	`id`	int	NOT NULL,
	`choiceBevIdList`	varchar	NOT NULL
);

CREATE TABLE `bevarageCategories` (
	`id`	int	NOT NULL,
	`bevCategoryName`	varchar	NULL,
	`subMenuId`	int	NOT NULL
);

CREATE TABLE `beverageImage` (
	`id`	int	NOT NULL,
	`beverageId`	int	NOT NULL,
	`originImage`	blob	NULL,
	`thumbnailImage`	blob	NULL,
	`originInfoImage`	blob	NULL,
	`thumbnailInfoImage`	blob	NULL
);

CREATE TABLE `beverageNutritionInformation` (
	`bevId`	int	NOT NULL,
	`calrory`	int	NULL,
	`sweets`	int	NULL,
	`protein`	int	NULL,
	`sodium`	int	NULL,
	`caffein`	int	NULL,
	`sizeId`	int	NOT NULL
);

CREATE TABLE `subMenu` (
	`id`	int	NOT NULL,
	`submenu_name`	varchar	NULL,
	`topMenuId`	int	NOT NULL
);

CREATE TABLE `region` (
	`id`	int	NOT NULL,
	`regionName`	varchar	NULL
);

CREATE TABLE `topMenu` (
	`id`	int	NOT NULL,
	`menu_name`	varchar	NULL
);

CREATE TABLE `bevarageSize` (
	`id`	int	NOT NULL,
	`sizeName`	varchar	NULL
);

CREATE TABLE `bevarage` (
	`id`	int	NOT NULL,
	`korName`	varchar	NULL,
	`engName`	varchar	NULL,
	`description`	text	NOT NULL,
	`releaseCategory`	enum	NULL,
	`sizeAvailability`	enum	NULL,
	`hotIceAvailability`	enum	NULL,
	`espressoShotPossibility`	int	NULL,
	`caffeinIncluded`	int	NULL,
	`alergicGeneratableIngredientList`	varchar	NOT NULL,
	`bevCategoryId`	int	NOT NULL,
	`regionId`	int	NOT NULL
);

CREATE TABLE `customerBevPick` (
	`id`	int	NOT NULL,
	`customerId`	int	NOT NULL,
	`beverageId`	int	NOT NULL,
	`pickDateTime`	datetime	NULL
);

CREATE TABLE `orderBeverage` (
	`id`	int	NOT NULL,
	`customerId`	int	NOT NULL,
	`beverageId`	int	NOT NULL,
	`sizeId`	int	NOT NULL,
	`orderDateTime`	datetime	NULL,
	`orderPrice`	int	NULL
);

CREATE TABLE `customizedOption` (
	`id`	int	NOT NULL,
	`optionName`	varchar	NULL,
	`extraPrice`	int	NULL
);

CREATE TABLE `orderOptionBeverage` (
	`id`	int	NOT NULL,
	`optionId`	int	NOT NULL,
	`id2`	int	NOT NULL,
	`customerId`	int	NOT NULL,
	`beverageId`	int	NOT NULL,
	`sizeId`	int	NOT NULL,
	`optionOrderPrice`	int	NULL
);

